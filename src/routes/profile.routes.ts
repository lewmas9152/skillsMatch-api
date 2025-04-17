// src/routes/profile.routes.ts
import express from 'express';
import { ProfileController } from '../controllers/profile.controller';
import { authMiddleware, roleMiddleware } from '../middlewares/auth.middleware';

const router = express.Router();

// All routes require authentication
router.use(authMiddleware);

// Basic profile management
router.get('/me', ProfileController.getProfile);
router.put('/me', ProfileController.updateBasicInfo);

// Experience management
router.post('/me/experience', ProfileController.addExperience);
router.put('/me/experience/:id', ProfileController.updateExperience);
router.delete('/me/experience/:id', ProfileController.deleteExperience);

// Education management
router.post('/me/education', ProfileController.addEducation);
router.put('/me/education/:id', ProfileController.updateEducation);
router.delete('/me/education/:id', ProfileController.deleteEducation);

// Skills management
router.post('/me/skills', ProfileController.addSkill);
router.delete('/me/skills/:id', ProfileController.deleteSkill);

// Social profiles management
router.post('/me/social', ProfileController.addSocialProfile);
router.delete('/me/social/:platform', ProfileController.deleteSocialProfile);

// CV management
router.post('/me/cv', ProfileController.addCV);
router.delete('/me/cv/:id', ProfileController.deleteCV);

export default router;