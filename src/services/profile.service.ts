// src/services/profile.service.ts
import { UserProfileModel } from '../models/userProfile.model';

export class ProfileService {
  static async getUserProfile(userId: number) {
    try {
      const profile = await UserProfileModel.findById(userId);
      
      if (!profile) {
        throw new Error('Profile not found');
      }
      
      return profile;
    } catch (error) {
      console.error('Error in getUserProfile service:', error);
      throw error;
    }
  }
  
  static async updateBasicInfo(userId: number, userData: {
    first_name?: string;
    last_name?: string;
    email?: string;
    phone_number?: string;
    bio?: string;
    profile_picture_url?: string;
  }) {
    try {
      const updatedUser = await UserProfileModel.updateBasicInfo(userId, userData);
      
      if (!updatedUser) {
        throw new Error('Failed to update profile');
      }
      
      return updatedUser;
    } catch (error) {
      console.error('Error in updateBasicInfo service:', error);
      throw error;
    }
  }
  
  static async addExperience(userId: number, experienceData: {
    title: string;
    company: string;
    location?: string;
    start_date: Date;
    end_date?: Date;
    is_current?: boolean;
    description?: string;
  }) {
    try {
      return await UserProfileModel.addExperience(userId, experienceData);
    } catch (error) {
      console.error('Error in addExperience service:', error);
      throw error;
    }
  }
  
  static async updateExperience(experienceId: number, userId: number, experienceData: {
    title?: string;
    company?: string;
    location?: string;
    start_date?: Date;
    end_date?: Date;
    is_current?: boolean;
    description?: string;
  }) {
    try {
      const updatedExperience = await UserProfileModel.updateExperience(experienceId, userId, experienceData);
      
      if (!updatedExperience) {
        throw new Error('Experience not found or no changes made');
      }
      
      return updatedExperience;
    } catch (error) {
      console.error('Error in updateExperience service:', error);
      throw error;
    }
  }
  
  static async deleteExperience(experienceId: number, userId: number) {
    try {
      const result = await UserProfileModel.deleteExperience(experienceId, userId);
      
      if (!result) {
        throw new Error('Experience not found');
      }
      
      return { message: 'Experience deleted successfully' };
    } catch (error) {
      console.error('Error in deleteExperience service:', error);
      throw error;
    }
  }
  
  static async addEducation(userId: number, educationData: {
    institution: string;
    degree: string;
    field_of_study: string;
    start_date: Date;
    end_date?: Date;
    is_current?: boolean;
    description?: string;
  }) {
    try {
      return await UserProfileModel.addEducation(userId, educationData);
    } catch (error) {
      console.error('Error in addEducation service:', error);
      throw error;
    }
  }
  
  static async updateEducation(educationId: number, userId: number, educationData: {
    institution?: string;
    degree?: string;
    field_of_study?: string;
    start_date?: Date;
    end_date?: Date;
    is_current?: boolean;
    description?: string;
  }) {
    try {
      const updatedEducation = await UserProfileModel.updateEducation(educationId, userId, educationData);
      
      if (!updatedEducation) {
        throw new Error('Education not found or no changes made');
      }
      
      return updatedEducation;
    } catch (error) {
      console.error('Error in updateEducation service:', error);
      throw error;
    }
  }
  
  static async deleteEducation(educationId: number, userId: number) {
    try {
      const result = await UserProfileModel.deleteEducation(educationId, userId);
      
      if (!result) {
        throw new Error('Education not found');
      }
      
      return { message: 'Education deleted successfully' };
    } catch (error) {
      console.error('Error in deleteEducation service:', error);
      throw error;
    }
  }
  
  static async addSkill(userId: number, skillData: {
    skill_id: number;
    proficiency_level: number;
  }) {
    try {
      return await UserProfileModel.addSkill(userId, skillData);
    } catch (error) {
      console.error('Error in addSkill service:', error);
      throw error;
    }
  }
  
  static async deleteSkill(userId: number, skillId: number) {
    try {
      const result = await UserProfileModel.deleteSkill(userId, skillId);
      
      if (!result) {
        throw new Error('Skill not found');
      }
      
      return { message: 'Skill deleted successfully' };
    } catch (error) {
      console.error('Error in deleteSkill service:', error);
      throw error;
    }
  }
  
  static async addSocialProfile(userId: number, socialData: {
    platform: string;
    url: string;
  }) {
    try {
      return await UserProfileModel.addSocialProfile(userId, socialData);
    } catch (error) {
      console.error('Error in addSocialProfile service:', error);
      throw error;
    }
  }
  
  static async deleteSocialProfile(userId: number, platformName: string) {
    try {
      const result = await UserProfileModel.deleteSocialProfile(userId, platformName);
      
      if (!result) {
        throw new Error('Social profile not found');
      }
      
      return { message: 'Social profile deleted successfully' };
    } catch (error) {
      console.error('Error in deleteSocialProfile service:', error);
      throw error;
    }
  }
  


  static async addCV(userId: number, fileName: string, fileUrl: string, isDefault = false) {
    return await UserProfileModel.addCV(userId, fileName, fileUrl, isDefault);
  }

  static async deleteCV(cvId: number, userId: number) {
    const deleted = await UserProfileModel.deleteCV(cvId, userId);
    if (!deleted) {
      throw new Error('CV not found or not authorized');
    }
    return deleted;
  }
}