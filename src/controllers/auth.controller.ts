// src/controllers/auth.controller.ts
import { Request, Response } from 'express';
import { AuthService } from '../services/auth.service';

export class AuthController {
  static async register(req: Request, res: Response) {
    try {
      const { first_name, last_name, email, password, phone_number, user_type, bio, profile_picture_url } = req.body;
      
      // Validate input
      if (!first_name || !last_name || !email || !password || !user_type) {
        return res.status(400).json({ message: 'All required fields must be provided' });
      }
      
      // Check if user_type is valid
      const validTypes = ['job_seeker', 'employer', 'admin', 'Job Seeker', 'Employer', 'Recruiter', 'Admin'];
      if (!validTypes.includes(user_type)) {
        return res.status(400).json({ message: 'Invalid user type' });
      }
      
      const result = await AuthService.register({
        first_name,
        last_name,
        email,
        password,
        phone_number,
        user_type,
        bio,
        profile_picture_url
      });
      console.log(result); // Check what's being received
      console.log("Creating user...");

      
      return res.status(201).json(result);
    } catch (error: any) {
      return res.status(400).json({ message: error.message });
    }
  }
  
  static async login(req: Request, res: Response) {
    try {
      const { email, password, remember_me } = req.body;
      
      // Validate input
      if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
      }
      
      const result = await AuthService.login(email, password, remember_me);
      
      return res.status(200).json(result);
    } catch (error: any) {
      return res.status(401).json({ message: error.message });
    }
  }
  
  static async forgotPassword(req: Request, res: Response) {
    try {
      const { email } = req.body;
      
      // Validate input
      if (!email) {
        return res.status(400).json({ message: 'Email is required' });
      }
      
      const result = await AuthService.forgotPassword(email);
      
      return res.status(200).json(result);
    } catch (error: any) {
      return res.status(400).json({ message: error.message });
    }
  }
  
  static async resetPassword(req: Request, res: Response) {
    try {
      const { token, new_password } = req.body;
      
      // Validate input
      if (!token || !new_password) {
        return res.status(400).json({ message: 'Token and new password are required' });
      }
      
      const result = await AuthService.resetPassword(token, new_password);
      
      return res.status(200).json(result);
    } catch (error: any) {
      return res.status(400).json({ message: error.message });
    }
  }
}