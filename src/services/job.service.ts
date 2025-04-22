// src/services/job.service.ts
import { JobModel } from '../models/job.model';
import { JobFilters, JobResponse } from '../interfaces/job.interface';

export class JobService {
  static async searchJobs(filters: JobFilters, limit = 10, offset = 0): Promise<JobResponse[]> {
    try {
      const jobs = await JobModel.findAll(filters, limit, offset);

      // Get skills for each job
      const jobsWithSkills = await Promise.all(
        jobs.map(async (job) => {
          const skills = await JobModel.getJobSkills(job.id);
          return {
            ...job,
            skills
          };
        })
      );

      return jobsWithSkills;
    } catch (error) {
      console.error('Error in searchJobs service:', error);
      throw error;
    }
  }

  static async getJobById(jobId: number): Promise<JobResponse | null> {
    try {
      const job = await JobModel.findById(jobId);
      if (!job) {
        return null;
      }

      const skills = await JobModel.getJobSkills(jobId);

      return {
        ...job,
        skills
      };
    } catch (error) {
      console.error('Error in getJobById service:', error);
      throw error;
    }
  }

  static async getSavedJobs(userId: number): Promise<JobResponse[]> {
    try {
      // Validate userId first
      if (typeof userId !== 'number' || isNaN(userId)) {
        throw new Error('Invalid user ID');
      }
      
      console.log('Fetching saved jobs for user:', userId);
      const savedJobs = await JobModel.getSavedJobs(userId);
      console.log('Raw savedJobs response:', savedJobs);


      // Add additional logging
      console.log(`Found ${savedJobs.length} saved jobs for user ${userId}`);

      // Get skills for each job with better error handling
      console.log('userId type:', typeof userId, 'value:', userId);
      console.log('savedJobs:', savedJobs);
      const jobsWithSkills = await Promise.all(
        savedJobs.map(async (job) => {
          try {
            const jobId = Number(job.id);
            if (typeof jobId !== 'number' || isNaN(jobId)) {
              console.error(`Invalid job ID found in saved jobs:`, job.id);
              return {
                ...job,
                skills: []
              };
            }
      
            const skills = await JobModel.getJobSkills(jobId);
            return {
              ...job,
              skills
            };
          } catch (skillError) {
            console.error(`Error getting skills for job ${job.id}:`, skillError);
            return {
              ...job,
              skills: []
            };
          }
        })
      );
      

      return jobsWithSkills;
    } catch (error) {
      console.error('Error in getSavedJobs service:', error);
      throw error;
    }
  }

  static async saveJob(userId: number, jobId: number): Promise<boolean> {
    return JobModel.saveJob(userId, jobId);
  }

  static async unsaveJob(userId: number, jobId: number): Promise<boolean> {
    return JobModel.unsaveJob(userId, jobId);
  }

  static async getRecommendedJobs(userId: number, limit = 10): Promise<JobResponse[]> {
    try {
      const recommendedJobs = await JobModel.getRecommendedJobs(userId, limit);

      // Get skills for each job
      const jobsWithSkills = await Promise.all(
        recommendedJobs.map(async (job) => {
          const skills = await JobModel.getJobSkills(job.id);
          return {
            ...job,
            skills
          };
        })
      );

      return jobsWithSkills;
    } catch (error) {
      console.error('Error in getRecommendedJobs service:', error);
      throw error;
    }
  }
}