import express from 'express';
import multer from 'multer';
import rateLimit from 'express-rate-limit';
import sgMail from '@sendgrid/mail';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables
dotenv.config({ path: './keys.env' });

const router = express.Router();

// 10MB file limit
const upload = multer({
  limits: { fileSize: 10 * 1024 * 1024 }
});

// --- Rate limiter: max 5 applications per IP per 24 hours ---
const applyLimiter = rateLimit({
  windowMs: 24 * 60 * 60 * 1000,
  max: 5,
  standardHeaders: true,
  legacyHeaders: false,
  handler: (req, res) => {
    res
      .status(429)
      .json({ error: 'Too many applications; please try again after 24 hours' });
  }
});

// --- SendGrid setup ---
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

// --- Apply Route ---
router.post(
  '/apply',
  applyLimiter,
  upload.single('cv'),
  async (req, res) => {
    try {
      const { fullName, phone, email, description, position } = req.body;

      if (!fullName || !email || !position || !req.file) {
        return res.status(400).json({ error: 'Missing fields' });
      }

      const textBody = `
New Job Application

Position: ${position}
Name: ${fullName}
Phone: ${phone || 'N/A'}
Email: ${email}

About Applicant:
${description}
      `;

      await sgMail.send({
        to: process.env.CAREERS_EMAIL,          // info@bazutel.com
        from: process.env.SENDGRID_FROM,        // info@bazutel.com (authenticated)
        replyTo: email,
        subject: `New Job Application – ${position}`,
        text: textBody,
        attachments: [
          {
            content: req.file.buffer.toString('base64'),
            filename: req.file.originalname,
            type: req.file.mimetype,
            disposition: 'attachment'
          }
        ]
      });

      res.json({
        status: 'OK',
        message: 'Application sent successfully'
      });
      //console.log('SENDGRID: Application email sent successfully');
    } catch (err) {
      console.error('SENDGRID ERROR:', err);
      res.status(500).json({ error: 'Failed to send application' });
    }
  }
);

export default router;
