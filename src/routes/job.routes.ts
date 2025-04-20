// src/routes/job.routes.ts
import express from 'express';
import { JobController } from '../controllers/job.controller';
import { authMiddleware } from '../middlewares/auth.middleware';

const router = express.Router();

// All routes require authentication
router.use(authMiddleware);

// Job search and matching
router.get('/search', JobController.searchJobs);
router.get('/recommended', JobController.getRecommendedJobs);

// Job details
router.get('/:id', JobController.getJobById);

// Saved jobs
router.get('/saved', JobController.getSavedJobs);
router.post('/:id/save', JobController.saveJob);
router.delete('/:id/save', JobController.unsaveJob);

export default router;