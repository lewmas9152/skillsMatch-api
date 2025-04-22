// src/controllers/job.controller.ts
import { Response } from 'express';
import { JobService } from '../services/job.service';
import { AuthRequest } from '../interfaces/auth.interface';

export class JobController {
  static async searchJobs(req: AuthRequest, res: Response): Promise<void> {
    try {
      const {
        title,
        location,
        salaryMin,
        salaryMax,
        experienceLevel,
        isRemote,
        department,
        skills,
        limit = 10,
        offset = 0
      } = req.query;

      const filters = {
        title: title as string,
        location: location as string,
        salaryMin: salaryMin ? parseInt(salaryMin as string) : undefined,
        salaryMax: salaryMax ? parseInt(salaryMax as string) : undefined,
        experienceLevel: experienceLevel as string,
        isRemote: isRemote === 'true',
        department: department as string,
        skills: skills ? (skills as string).split(',').map(Number) : undefined
      };

      const jobs = await JobService.searchJobs(
        filters, 
        parseInt(limit as string), 
        parseInt(offset as string)
      );
      
      res.status(200).json({
        success: true,
        data: jobs
      });
      return;
    } catch (error) {
      console.error('Error in searchJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to search jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }

  static async getJobById(req: AuthRequest, res: Response): Promise<void> {
    try {
      console.log('Request parameters:', req.params);
      const jobId = parseInt(req.params.id);
      const job = await JobService.getJobById(jobId);
      
      if (!job) {
        res.status(404).json({
          success: false,
          message: 'Job not found'
        });
        return;
      }
      
      res.status(200).json({
        success: true,
        data: job
      });
      return;
    } catch (error) {
      console.error('Error in getJobById controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get job details',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }

  static async getSavedJobs(req: AuthRequest, res: Response): Promise<void> {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      console.log('User object from request:', req.user);
      console.log('User ID being used:', req.user.userId);
      const savedJobs = await JobService.getSavedJobs(req.user.userId);
      
      res.status(200).json({
        success: true,
        data: savedJobs
      });
      return;
    } catch (error) {
      console.error('Error in getSavedJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get saved jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }

  static async saveJob(req: AuthRequest, res: Response): Promise<void> {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }
  
      // Log the user object for debugging
      console.log('User object from request:', req.user);
      console.log('User ID being used:', req.user.userId);
  
      const jobId = parseInt(req.params.id);
      console.log('Job ID being used:', jobId);
      
      const success = await JobService.saveJob(req.user.userId, jobId);
      
      res.status(200).json({
        success: true,
        message: 'Job saved successfully'
      });
      return;
    } catch (error) {
      console.error('Error in saveJob controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to save job',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }

  static async unsaveJob(req: AuthRequest, res: Response): Promise<void> {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const jobId = parseInt(req.params.id);
      
      const success = await JobService.unsaveJob(req.user.userId, jobId);
      
      if (!success) {
        res.status(404).json({
          success: false,
          message: 'Saved job not found'
        });
        return;
      }
      
      res.status(200).json({
        success: true,
        message: 'Job removed from saved jobs'
      });
      return;
    } catch (error) {
      console.error('Error in unsaveJob controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to remove job from saved jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }

  static async getRecommendedJobs(req: AuthRequest, res: Response): Promise<void> {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const limit = req.query.limit ? parseInt(req.query.limit as string) : 10;
      
      const recommendedJobs = await JobService.getRecommendedJobs(req.user.userId, limit);
      
      res.status(200).json({
        success: true,
        data: recommendedJobs
      });
      return;
    } catch (error) {
      console.error('Error in getRecommendedJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get recommended jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
      return;
    }
  }
}