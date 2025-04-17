// src/models/userProfile.model.ts
import db from '../config/database';

export interface UserProfile {
  user_id: number;
  first_name: string;
  last_name: string;
  email: string;
  phone_number?: string;
  bio?: string;
  profile_picture_url?: string;
  location?: string;
  experience?: any[];
  education?: any[];
  skills?: any[];
  social_profiles?: any[];
  cv_url?: string;
}

export class UserProfileModel {
  static async findById(userId: number): Promise<UserProfile | null> {
    try {
      // Get basic user info
      const userQuery = `
        SELECT u.user_id, u.first_name, u.last_name, u.email, u.phone_number, 
               u.bio, u.profile_picture_url, u.created_at, u.updated_at
        FROM users u
        WHERE u.user_id = $1 AND u.is_active = true
      `;
      const userResult = await db.query(userQuery, [userId]);

      if (userResult.rows.length === 0) {
        return null;
      }

      const user = userResult.rows[0];

      // Get user experience
      const experienceQuery = `
        SELECT * FROM experience 
        WHERE user_id = $1
        ORDER BY start_date DESC
      `;
      const experienceResult = await db.query(experienceQuery, [userId]);

      // Get user education
      const educationQuery = `
        SELECT * FROM education
        WHERE user_id = $1
        ORDER BY start_date DESC
      `;
      const educationResult = await db.query(educationQuery, [userId]);

      // Get user skills
      const skillsQuery = `
        SELECT s.skill_id, s.skill_name, s.description, us.proficiency_level
        FROM user_skills us
        JOIN skills s ON us.skill_id = s.skill_id
        WHERE us.user_id = $1
      `;
      const skillsResult = await db.query(skillsQuery, [userId]);

      // Get social profiles
      const socialQuery = `
        SELECT * FROM social_profiles
        WHERE user_id = $1
      `;
      const socialResult = await db.query(socialQuery, [userId]);

      // Get CV
      const cvQuery = `
        SELECT file_url FROM user_cvs
        WHERE user_id = $1
        ORDER BY updated_at DESC
        LIMIT 1
      `;
      const cvResult = await db.query(cvQuery, [userId]);

      return {
        ...user,
        experience: experienceResult.rows,
        education: educationResult.rows,
        skills: skillsResult.rows,
        social_profiles: socialResult.rows,
        cv_url: cvResult.rows.length > 0 ? cvResult.rows[0].cv_url : null
      };
    } catch (error) {
      console.error('Error finding user profile:', error);
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
      // Build query dynamically based on provided fields
      const fields: string[] = [];
      const values: any[] = [];
      let paramCounter = 1;

      for (const [key, value] of Object.entries(userData)) {
        if (value !== undefined) {
          fields.push(`${key} = $${paramCounter}`);
          values.push(value);
          paramCounter++;
        }
      }

      if (fields.length === 0) {
        return null; // No fields to update
      }

      values.push(userId);

      const query = `
        UPDATE users
        SET ${fields.join(', ')}, updated_at = NOW()
        WHERE user_id = $${paramCounter}
        RETURNING user_id, first_name, last_name, email, phone_number, bio, profile_picture_url
      `;

      const result = await db.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error updating user profile:', error);
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
      const query = `
        INSERT INTO experience (
          user_id, title, company_name, location, start_date, end_date, is_current, description
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *
      `;

      const values = [
        userId,
        experienceData.title,
        experienceData.company,
        experienceData.location || null,
        experienceData.start_date,
        experienceData.end_date || null,
        experienceData.is_current || false,
        experienceData.description || null
      ];

      const result = await db.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error adding experience:', error);
      throw error;
    }
  }

  static async updateExperience(
    experienceId: number,
    userId: number,
    experienceData: {
      title?: string;
      company?: string;
      location?: string;
      start_date?: Date;
      end_date?: Date;
      is_current?: boolean;
      description?: string;
    }
  ) {
    try {
      const fields: string[] = [];
      const values: any[] = [];
      let paramCounter = 1;

      // Map our JS keys to actual DB columns
      const columnMap: Record<string, string> = {
        company: 'company_name',
      };

      for (const [key, value] of Object.entries(experienceData)) {
        if (value === undefined) continue;

        // pick the real column name (fall back to the key itself)
        const column = columnMap[key] || key;

        fields.push(`${column} = $${paramCounter}`);
        values.push(value);
        paramCounter++;
      }

      if (fields.length === 0) {
        // nothing to change
        return null;
      }

      // finally, bind our WHERE params
      values.push(experienceId);      // $n
      values.push(userId);            // $n+1

      const query = `
        UPDATE experience
        SET ${fields.join(', ')}
        WHERE experience_id = $${paramCounter}
          AND user_id        = $${paramCounter + 1}
        RETURNING *
      `;

      const result = await db.query(query, values);
      return result.rows[0];

    } catch (error) {
      console.error('Error updating experience:', error);
      throw error;
    }
  }


  static async deleteExperience(experienceId: number, userId: number) {
    try {
      const query = `
        DELETE FROM experience
        WHERE experience_id = $1 AND user_id = $2
        RETURNING experience_id
      `;

      const result = await db.query(query, [experienceId, userId]);
      return result.rows[0];
    } catch (error) {
      console.error('Error deleting experience:', error);
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
      const query = `
        INSERT INTO education (
          user_id, institution_name, degree, field_of_study, start_date, end_date, is_current, description
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *
      `;

      const values = [
        userId,
        educationData.institution,
        educationData.degree,
        educationData.field_of_study,
        educationData.start_date,
        educationData.end_date || null,
        educationData.is_current || false,
        educationData.description || null
      ];

      const result = await db.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error adding education:', error);
      throw error;
    }
  }

  static async updateEducation(
    educationId: number,
    userId: number,
    educationData: {
      institution?: string;
      degree?: string;
      field_of_study?: string;
      start_date?: Date;
      end_date?: Date;
      is_current?: boolean;
      description?: string;
    }
  ) {
    try {
      const fields: string[] = [];
      const values: any[] = [];
      let paramCounter = 1;

      // Map your JS keys to actual DB columns
      const columnMap: Record<string, string> = {
        institution: 'institution_name',
        // add more here if you ever rename other fields
      };

      for (const [key, value] of Object.entries(educationData)) {
        if (value === undefined) continue;

        // look up the real column name, default to the key
        const column = columnMap[key] || key;
        fields.push(`${column} = $${paramCounter}`);
        values.push(value);
        paramCounter++;
      }

      if (fields.length === 0) {
        // nothing to change
        return null;
      }

      // bind the WHERE params
      values.push(educationId); // $n
      values.push(userId);      // $n+1

      const query = `
        UPDATE education
        SET ${fields.join(', ')}
        WHERE education_id = $${paramCounter}
          AND user_id        = $${paramCounter + 1}
        RETURNING *
      `;

      const result = await db.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error updating education:', error);
      throw error;
    }
  }


  static async deleteEducation(educationId: number, userId: number) {
    try {
      const query = `
        DELETE FROM education
        WHERE education_id = $1 AND user_id = $2
        RETURNING education_id
      `;

      const result = await db.query(query, [educationId, userId]);
      return result.rows[0];
    } catch (error) {
      console.error('Error deleting education:', error);
      throw error;
    }
  }

  static async addSkill(userId: number, skillData: {
    skill_id: number;
    proficiency_level: number;
  }) {
    try {
      const query = `
        INSERT INTO user_skills (user_id, skill_id, proficiency_level)
        VALUES ($1, $2, $3)
        ON CONFLICT (user_id, skill_id)
        DO UPDATE SET proficiency_level = $3
        RETURNING *
      `;

      const values = [
        userId,
        skillData.skill_id,
        skillData.proficiency_level
      ];

      const result = await db.query(query, values);

      // Get the skill details
      const skillQuery = `
        SELECT s.skill_id, s.skill_name, s.description, us.proficiency_level
        FROM user_skills us
        JOIN skills s ON us.skill_id = s.skill_id
        WHERE us.user_id = $1 AND us.skill_id = $2
      `;

      const skillResult = await db.query(skillQuery, [userId, skillData.skill_id]);
      return skillResult.rows[0];
    } catch (error) {
      console.error('Error adding skill:', error);
      throw error;
    }
  }

  static async deleteSkill(userId: number, skillId: number) {
    try {
      const query = `
        DELETE FROM user_skills
        WHERE user_id = $1 AND skill_id = $2
        RETURNING skill_id
      `;

      const result = await db.query(query, [userId, skillId]);
      return result.rows[0];
    } catch (error) {
      console.error('Error deleting skill:', error);
      throw error;
    }
  }

  static async addSocialProfile(userId: number, socialData: {
    platform: string;
    url: string;
  }) {
    try {
      const query = `
        INSERT INTO social_profiles (user_id, platform, url)
        VALUES ($1, $2, $3)
        ON CONFLICT (user_id, platform)
        DO UPDATE SET url = $3
        RETURNING *
      `;

      const values = [
        userId,
        socialData.platform,
        socialData.url
      ];

      const result = await db.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error adding social profile:', error);
      throw error;
    }
  }

  static async deleteSocialProfile(userId: number, platformName: string) {
    try {
      const query = `
        DELETE FROM social_profiles
        WHERE user_id = $1 AND platform = $2
        RETURNING social_profile_id
      `;

      const result = await db.query(query, [userId, platformName]);
      return result.rows[0];
    } catch (error) {
      console.error('Error deleting social profile:', error);
      throw error;
    }
  }

 

  static async addCV(userId: number, fileName: string, fileUrl: string, isDefault = false) {
    const query = `
      INSERT INTO user_cvs (user_id, file_name, file_url, is_default, created_at, updated_at)
      VALUES ($1, $2, $3, $4, NOW(), NOW())
      RETURNING *
    `;
    const values = [userId, fileName, fileUrl, isDefault];
    const result = await db.query(query, values);
    return result.rows[0];
  }

  static async deleteCV(cvId: number, userId: number) {
    const query = `
      DELETE FROM user_cvs WHERE cv_id = $1 AND user_id = $2 RETURNING *
    `;
    const result = await db.query(query, [cvId, userId]);
    return result.rows[0];
  }
}