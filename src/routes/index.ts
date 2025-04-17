
import express from 'express';
import authRoutes from './auth.routes';
import profileRoutes from './profile.routes';

const router = express.Router();

router.use('/auth', authRoutes);
router.use('/profile', profileRoutes);

export default router;