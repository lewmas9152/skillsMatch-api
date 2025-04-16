// src/routes/auth.routes.ts
import { Router } from 'express';
import { AuthController } from '../controllers/auth.controller';

const router = Router();

// Public routes
router.post('/register', (req, res, next) => {
    AuthController.register(req, res).catch(next);
});

router.post('/login', (req, res, next) => {
    AuthController.login(req, res).catch(next);
});

router.post('/forgot-password', (req, res, next) => {
    AuthController.forgotPassword(req, res).catch(next);
});

router.post('/reset-password', (req, res, next) => {
    AuthController.resetPassword(req, res).catch(next);
});

export default router;