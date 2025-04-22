// src/models/job.model.ts
import { Pool } from 'pg';
import db from '../config/database';
import { Job } from '../interfaces/job.interface';
import { JobSkill } from '../interfaces/job.interface';



export class JobModel {
  static async findAll(filters: any = {}, limit = 10, offset = 0): Promise<Job[]> {
    try {
      let query = `
        SELECT j.* FROM jobs j
        WHERE 1=1
      `;
      const queryParams: any[] = [];
      let paramIndex = 1;

      if (filters.title) {
        query += ` AND j.title ILIKE $${paramIndex}`;
        queryParams.push(`%${filters.title}%`);
        paramIndex++;
      }

      if (filters.location) {
        query += ` AND (j.location ILIKE $${paramIndex} OR j.is_remote = true)`;
        queryParams.push(`%${filters.location}%`);
        paramIndex++;
      }

      if (filters.salaryMin) {
        query += ` AND j.salary_max >= $${paramIndex}`;
        queryParams.push(filters.salaryMin);
        paramIndex++;
      }

      if (filters.experienceLevel) {
        query += ` AND j.experience_level = $${paramIndex}`;
        queryParams.push(filters.experienceLevel);
        paramIndex++;
      }

      if (filters.isRemote !== undefined) {
        query += ` AND j.is_remote = $${paramIndex}`;
        queryParams.push(filters.isRemote);
        paramIndex++;
      }

      if (filters.department) {
        query += ` AND j.department = $${paramIndex}`;
        queryParams.push(filters.department);
        paramIndex++;
      }

      if (filters.status) {
        query += ` AND j.status = $${paramIndex}`;
        queryParams.push(filters.status);
        paramIndex++;
      } else {
        query += ` AND j.status = 'active'`;
      }

      query += ` ORDER BY j.posted_date DESC LIMIT $${paramIndex} OFFSET $${paramIndex+1}`;
      queryParams.push(limit, offset);

      const result = await db.query(query, queryParams);
      return result.rows;
    } catch (error) {
      console.error('Error in findAll jobs:', error);
      throw error;
    }
  }

  static async findById(id: number): Promise<Job | null> {
    try {
      const result = await db.query('SELECT * FROM jobs WHERE job_id = $1', [id]);
      if (result.rows.length === 0) {
        return null;
      }
      return result.rows[0];
    } catch (error) {
      console.error('Error in findById job:', error);
      throw error;
    }
  }

  static async getJobSkills(jobId: number): Promise<any[]> {
    try {
      const query = `
        SELECT js.job_skill_id, s.skill_name, s.category_id, js.importance_level
        FROM job_skills js
        JOIN skills s ON js.skill_id = s.skill_id
        WHERE js.job_id = $1
      `;
      const result = await db.query(query, [jobId]);
      return result.rows;
    } catch (error) {
      console.error('Error in getJobSkills:', error);
      throw error;
    }
  }

  static async getSavedJobs(userId: number): Promise<Job[]> {
    try {
      const query = `
        SELECT j.* 
        FROM jobs j
        JOIN saved_jobs sj ON j.job_id = sj.job_id
        WHERE sj.user_id = $1 AND j.is_active = true
        ORDER BY sj.saved_date DESC
      `;
      const result = await db.query(query, [userId]);
      return result.rows;
    } catch (error) {
      console.error('Error in getSavedJobs:', error);
      throw error;
    }
  }

  static async saveJob(userId: number, jobId: number): Promise<boolean> {
    try {
      await db.query(
        'INSERT INTO saved_jobs (user_id, job_id, saved_date) VALUES ($1, $2, NOW()) ON CONFLICT DO NOTHING',
        [userId, jobId]
      );
      return true;
    } catch (error) {
      console.error('Error in saveJob:', error);
      throw error;
    }
  }

  static async unsaveJob(userId: number, jobId: number): Promise<boolean> {
    try {
      const result = await db.query(
        'DELETE FROM saved_jobs WHERE user_id = $1 AND job_id = $2',
        [userId, jobId]
      );
      return result.rowCount !== null && result.rowCount > 0;
    } catch (error) {
      console.error('Error in unsaveJob:', error);
      throw error;
    }
  }

  static async getRecommendedJobs(userId: number, limit = 10): Promise<Job[]> {
    try {
      // This is a simplified version of skill matching algorithm
      const query = `
        WITH user_skills AS (
          SELECT skill_id FROM user_skills WHERE user_id = $1
        ),
        job_skill_match AS (
          SELECT 
            j.id AS job_id,
            COUNT(CASE WHEN us.skill_id IS NOT NULL THEN 1 END) AS matched_skills,
            COUNT(js.skill_id) AS total_skills,
            CASE 
              WHEN COUNT(js.skill_id) > 0 THEN 
                (COUNT(CASE WHEN us.skill_id IS NOT NULL THEN 1 END)::float / COUNT(js.skill_id)) * 100
              ELSE 0
            END AS match_percentage
          FROM jobs j
          JOIN job_skills js ON j.id = js.job_id
          LEFT JOIN user_skills us ON js.skill_id = us.skill_id
          WHERE j.status = 'active'
          GROUP BY j.id
        )
        SELECT j.*, jsm.match_percentage
        FROM jobs j
        JOIN job_skill_match jsm ON j.id = jsm.job_id
        WHERE j.status = 'active'
        ORDER BY jsm.match_percentage DESC, j.posted_date DESC
        LIMIT $2
      `;
      
      const result = await db.query(query, [userId, limit]);
      return result.rows;
    } catch (error) {
      console.error('Error in getRecommendedJobs:', error);
      throw error;
    }
  }
}