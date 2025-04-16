// src/services/auth.service.ts
import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import { UserModel, User } from '../models/user.model';
import { UserTypeModel } from '../models/userType.model';
import db from '../config/database';

export class AuthService {
  static async register(userData: {
    first_name: string;
    last_name: string;
    email: string;
    password: string;
    phone_number?: string;
    user_type: string; // 'job_seeker', 'employer', 'recruiter', 'admin'
    bio?: string;
    profile_picture_url?: string;
  }) {
    // Check if user already exists
    const existingUser = await UserModel.findByEmail(userData.email);
    if (existingUser) {
      throw new Error('User with this email already exists');
    }
    
    // Map user type string to corresponding ID
    let userTypeId: number;
    
    switch(userData.user_type.toLowerCase()) {
      case 'job seeker':
      case 'job_seeker':
        userTypeId = 1;
        break;
      case 'employer':
        userTypeId = 2;
        break;
      case 'recruiter':
        userTypeId = 3;
        break;
      case 'admin':
        userTypeId = 4;
        break;
      default:
        userTypeId = 1; // Default to Job Seeker
    }
    
    // Create new user
    const user = await UserModel.createUser({
      user_type_id: userTypeId,
      first_name: userData.first_name,
      last_name: userData.last_name,
      email: userData.email,
      password: userData.password,
      phone_number: userData.phone_number,
      bio: userData.bio,
      profile_picture_url: userData.profile_picture_url
    });
    
    // Remove password from response
    const { password_hash, ...userWithoutPassword } = user;
    
    return userWithoutPassword;
  }
  
  static async login(email: string, password: string, rememberMe: boolean = false) {
    // Find user by email
    const user = await UserModel.findByEmail(email);
    if (!user) {
      throw new Error('Invalid credentials');
    }
    
    // Check password
    const isPasswordValid = await bcrypt.compare(password, user.password_hash);
    if (!isPasswordValid) {
      throw new Error('Invalid credentials');
    }
    
    // Check if user is active
    if (!user.is_active) {
      throw new Error('Account is disabled. Please contact support.');
    }
    
    // Get user type from our existing mapping
    let userTypeName: string;
    
    switch(user.user_type_id) {
      case 1:
        userTypeName = 'job_seeker';
        break;
      case 2:
        userTypeName = 'employer';
        break;
      case 3:
        userTypeName = 'recruiter';
        break;
      case 4:
        userTypeName = 'admin';
        break;
      default:
        userTypeName = 'job_seeker';
    }
    
    // Generate token
    const token = jwt.sign(
      { userId: user.user_id, email: user.email, userType: userTypeName },
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '24h' }
    );
    
    // Generate remember me token if requested
    if (rememberMe) {
      const rememberMeToken = jwt.sign(
        { userId: user.user_id },
        process.env.JWT_REMEMBER_SECRET || 'remember-secret-key',
        { expiresIn: '30d' }
      );
      await UserModel.updateRememberMeToken(user.user_id, rememberMeToken);
    }
    
    // Remove password from response
    const { password_hash: _, ...userWithoutPassword } = user;
    
    return {
      user: {
        ...userWithoutPassword,
        user_type: userTypeName
      },
      token
    };
  }
  
  static async forgotPassword(email: string) {
    // Find user by email
    const user = await UserModel.findByEmail(email);
    if (!user) {
      throw new Error('User not found');
    }
    
    // Generate reset token
    const resetToken = jwt.sign(
      { userId: user.user_id },
      process.env.JWT_RESET_SECRET || 'reset-secret-key',
      { expiresIn: '1h' }
    );
    
    // In a real application, you would send an email with a reset link
    // For demonstration, we'll just return the token
    return { message: 'Password reset instructions sent', resetToken };
  }
  
  static async resetPassword(token: string, newPassword: string) {
    try {
      // Verify token
      const decoded = jwt.verify(token, process.env.JWT_RESET_SECRET || 'reset-secret-key') as { userId: number };
      
      // Find user
      const user = await UserModel.findById(decoded.userId);
      if (!user) {
        throw new Error('User not found');
      }
      
      // Hash new password
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      
      // Update user's password in the database
      const query = 'UPDATE users SET password_hash = $1 WHERE user_id = $2';
      await db.query(query, [hashedPassword, user.user_id]);
      
      return { message: 'Password updated successfully' };
    } catch (error) {
      throw new Error('Invalid or expired token');
    }
  }
}