
import express from 'express';
import authRoutes from './auth.routes';
import profileRoutes from './profile.routes';
import jobRoutes from './job.routes';

const router = express.Router();

router.use('/auth', authRoutes);
router.use('/profile', profileRoutes);
router.use('/jobs', jobRoutes);

export default router;