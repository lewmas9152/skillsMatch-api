// src/models/user.model.ts
import db from '../config/database';
import bcrypt from 'bcryptjs';

export interface User {
  user_id: number;
  user_type_id: number;
  email: string;
  password_hash: string;
  first_name: string;
  last_name: string;
  phone_number?: string;
  profile_picture_url?: string;
  bio?: string;
  is_verified: boolean;
  is_active: boolean;
  remember_me_token?: string;
  created_at: Date;
  updated_at: Date;
}

export class UserModel {
  static async createUser(userData: {
    first_name: string;
    last_name: string;
    email: string;
    password: string;
    phone_number?: string;
    user_type_id: number;
    profile_picture_url?: string;
    bio?: string;
  }): Promise<User> {
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    
    const query = `
      INSERT INTO users (
        user_type_id, email, password_hash, first_name, last_name, 
        phone_number, profile_picture_url, bio, is_verified, is_active
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;
    
    const values = [
      userData.user_type_id,
      userData.email.toLowerCase(),
      hashedPassword,
      userData.first_name,
      userData.last_name,
      userData.phone_number || null,
      userData.profile_picture_url || null,
      userData.bio || null,
      false, // is_verified defaults to false
      true   // is_active defaults to true
    ];
    
    const result = await db.query(query, values);
    return result.rows[0];
  }
  
  static async findByEmail(email: string): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE email = $1';
    const result = await db.query(query, [email.toLowerCase()]);
    
    return result.rows.length ? result.rows[0] : null;
  }
  
  static async findById(id: number): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE user_id = $1';
    const result = await db.query(query, [id]);
    
    return result.rows.length ? result.rows[0] : null;
  }
  
  static async updateRememberMeToken(userId: number, token: string): Promise<void> {
    const query = 'UPDATE users SET remember_me_token = $1 WHERE user_id = $2';
    await db.query(query, [token, userId]);
  }
}