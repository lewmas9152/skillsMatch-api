// src/interfaces/auth.interface.ts
import { Request } from 'express';

export interface AuthRequest extends Request {
  user?: {
    userId: number;
    email: string;
    userType: string;
  };
}