// src/models/userType.model.ts
import db from '../config/database';

export interface UserType {
  type_id: number;
  type_name: string;
}

export class UserTypeModel {
  static async findAll(): Promise<UserType[]> {
    const query = 'SELECT * FROM user_types';
    const result = await db.query(query);
    return result.rows;
  }
  
  static async findByName(typeName: string): Promise<UserType | null> {
    const query = 'SELECT * FROM user_types WHERE type_name = $1';
    const result = await db.query(query, [typeName]);
    return result.rows.length ? result.rows[0] : null;
  }
  
  static async findById(id: number): Promise<UserType | null> {
    const query = 'SELECT * FROM user_types WHERE type_id = $1';
    const result = await db.query(query, [id]);
    return result.rows.length ? result.rows[0] : null;
  }
  
  static getTypeIdByName(typeName: string): number {
    const typeMap: { [key: string]: number } = {
      'job_seeker': 1,
      'employer': 2,
      'recruiter': 3,
      'admin': 4
    };
    
    return typeMap[typeName.toLowerCase()] || 1; // Default to Job Seeker if not found
  }
}