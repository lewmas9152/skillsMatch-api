// src/controllers/profile.controller.ts
import { Request, Response } from 'express';
import { ProfileService } from '../services/profile.service';

import { AuthRequest } from '../interfaces/auth.interface';

export class ProfileController {
  static async getProfile(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const profile = await ProfileService.getUserProfile(req.user.userId);

      res.status(200).json(profile);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async updateBasicInfo(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const { first_name, last_name, email, phone_number, bio, profile_picture_url } = req.body;

      const updatedProfile = await ProfileService.updateBasicInfo(req.user.userId, {
        first_name,
        last_name,
        email,
        phone_number,
        bio,
        profile_picture_url
      });

      res.status(200).json(updatedProfile);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async addExperience(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const { title, company, location, start_date, end_date, is_current, description } = req.body;

      // Validate required fields
      if (!title || !company || !start_date) {
        res.status(400).json({ message: 'Title, company, and start date are required' });
        return
      }

      const newExperience = await ProfileService.addExperience(req.user.userId, {
        title,
        company,
        location,
        start_date: new Date(start_date),
        end_date: end_date ? new Date(end_date) : undefined,
        is_current,
        description
      });

      res.status(201).json(newExperience);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async updateExperience(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const experienceId = parseInt(req.params.id);
      const { title, company, location, start_date, end_date, is_current, description } = req.body;

      const updatedExperience = await ProfileService.updateExperience(experienceId, req.user.userId, {
        title,
        company,
        location,
        start_date: start_date ? new Date(start_date) : undefined,
        end_date: end_date ? new Date(end_date) : undefined,
        is_current,
        description
      });


      res.status(200).json(updatedExperience);
      return;
    } catch (error: any) {

      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async deleteExperience(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {

        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const experienceId = parseInt(req.params.id);

      const result = await ProfileService.deleteExperience(experienceId, req.user.userId);


      res.status(200).json(result);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async addEducation(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const { institution, degree, field_of_study, start_date, end_date, is_current, description } = req.body;

      // Validate required fields
      if (!institution || !degree || !field_of_study || !start_date) {
        res.status(400).json({ message: 'Institution, degree, field of study, and start date are required' });
        return;
      }

      const newEducation = await ProfileService.addEducation(req.user.userId, {
        institution,
        degree,
        field_of_study,
        start_date: new Date(start_date),
        end_date: end_date ? new Date(end_date) : undefined,
        is_current,
        description
      });

      res.status(201).json(newEducation);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async updateEducation(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const educationId = parseInt(req.params.id);
      const { institution, degree, field_of_study, start_date, end_date, is_current, description } = req.body;

      const updatedEducation = await ProfileService.updateEducation(educationId, req.user.userId, {
        institution,
        degree,
        field_of_study,
        start_date: start_date ? new Date(start_date) : undefined,
        end_date: end_date ? new Date(end_date) : undefined,
        is_current,
        description
      });

      res.status(200).json(updatedEducation);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async deleteEducation(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const educationId = parseInt(req.params.id);

      const result = await ProfileService.deleteEducation(educationId, req.user.userId);

      res.status(200).json(result);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async addSkill(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const { skill_id, proficiency_level } = req.body;

      // Validate required fields
      if (!skill_id || proficiency_level === undefined) {
        res.status(400).json({ message: 'Skill ID and proficiency level are required' });
        return;
      }

      const newSkill = await ProfileService.addSkill(req.user.userId, {
        skill_id,
        proficiency_level
      });

      res.status(201).json(newSkill);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async deleteSkill(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const skillId = parseInt(req.params.id);

      const result = await ProfileService.deleteSkill(req.user.userId, skillId);


      res.status(200).json(result);
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async addSocialProfile(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const { platform, url } = req.body;

      // Validate required fields
      if (!platform || !url) {
        res.status(400).json({ message: 'Platform and URL are required' });
        return;
      }

      const newSocialProfile = await ProfileService.addSocialProfile(req.user.userId, {
        platform,
        url
      });

      res.status(201).json(newSocialProfile);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }

  static async deleteSocialProfile(req: AuthRequest, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Authentication required' });
        return;
      }

      const platform = req.params.platform;

      const result = await ProfileService.deleteSocialProfile(req.user.userId, platform);

      res.status(200).json(result);
      return;
    } catch (error: any) {
      res.status(400).json({ message: error.message });
      return;
    }
  }



  static async addCV(req: any, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Unauthorized' });
        return;
      }

      const { file_name, file_url, is_default } = req.body;
      if (!file_name || !file_url) {
        res.status(400).json({ message: 'file_name and file_url are required' });
        return;
      }

      const newCV = await ProfileService.addCV(req.user.userId, file_name, file_url, is_default);
      res.status(201).json(newCV);
      return;
    } catch (error: any) {
      console.error('Add CV Error:', error);
      res.status(500).json({ message: error.message });
      return;
    }
  }

  static async deleteCV(req: any, res: Response) {
    try {
      if (!req.user) {
        res.status(401).json({ message: 'Unauthorized' });
        return;
      }

      const cvId = parseInt(req.params.id);
      if (isNaN(cvId)) {
        res.status(400).json({ message: 'Invalid CV ID' });
        return;
      }

      const deleted = await ProfileService.deleteCV(cvId, req.user.userId);
      res.status(200).json({ message: 'CV deleted', data: deleted });
      return;
    } catch (error: any) {
      console.error('Delete CV Error:', error);
      res.status(500).json({ message: error.message });
      return;

    }
  }
}