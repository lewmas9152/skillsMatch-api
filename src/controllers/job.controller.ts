// src/controllers/job.controller.ts
import { Request, Response } from 'express';
import { JobService } from '../services/job.service';

export class JobController {
  static async searchJobs(req: Request, res: Response): Promise<void> {
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
    } catch (error) {
      console.error('Error in searchJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to search jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }

  static async getJobById(req: Request, res: Response): Promise<void> {
    try {
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
    } catch (error) {
      console.error('Error in getJobById controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get job details',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }

  static async getSavedJobs(req: Request, res: Response): Promise<void> {
    try {
      const userId = (req as any).user.id;
      const savedJobs = await JobService.getSavedJobs(userId);
      
      res.status(200).json({
        success: true,
        data: savedJobs
      });
    } catch (error) {
      console.error('Error in getSavedJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get saved jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }

  static async saveJob(req: Request, res: Response): Promise<void> {
    try {
      const userId = (req as any).user.id;
      const jobId = parseInt(req.params.id);
      
      const success = await JobService.saveJob(userId, jobId);
      
      res.status(200).json({
        success: true,
        message: 'Job saved successfully'
      });
    } catch (error) {
      console.error('Error in saveJob controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to save job',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }

  static async unsaveJob(req: Request, res: Response): Promise<void> {
    try {
      const userId = (req as any).user.id;
      const jobId = parseInt(req.params.id);
      
      const success = await JobService.unsaveJob(userId, jobId);
      
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
    } catch (error) {
      console.error('Error in unsaveJob controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to remove job from saved jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }

  static async getRecommendedJobs(req: Request, res: Response): Promise<void> {
    try {
      const userId = (req as any).user.id;
      const limit = req.query.limit ? parseInt(req.query.limit as string) : 10;
      
      const recommendedJobs = await JobService.getRecommendedJobs(userId, limit);
      
      res.status(200).json({
        success: true,
        data: recommendedJobs
      });
    } catch (error) {
      console.error('Error in getRecommendedJobs controller:', error);
      res.status(500).json({
        success: false,
        message: 'Failed to get recommended jobs',
        error: error instanceof Error ? error.message : 'Unknown error'
      });
    }
  }
}