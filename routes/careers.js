import express from 'express';
import multer from 'multer';
import rateLimit from 'express-rate-limit';
import nodemailer from 'nodemailer';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables
dotenv.config({ path: './keys.env' });

const router = express.Router();
const upload = multer({ limits: { fileSize: 10 * 1024 * 1024 } }); // 10MB

// --- Rate limiter: max 5 requests per IP per 24 hours ---
const applyLimiter = rateLimit({
  windowMs: 24 * 60 * 60 * 1000, // 24 hours
  max: 5, // limit each IP to 5 requests per windowMs
  message: { error: 'Too many applications from this IP, please try again after 24 hours' },
  standardHeaders: true, // Return rate limit info in the `RateLimit-*` headers
  legacyHeaders: false, // Disable the `X-RateLimit-*` headers
  handler: (req, res) => {
    res.status(429).json({ error: 'Too many applications; please try again after 24 hours' });
  }
});

// --- Nodemailer transporter ---
// Use port 465 for SSL or 587 for STARTTLS depending on your cPanel


const transporter = nodemailer.createTransport({
  host: 'rbx109.truehost.cloud',
  port: 587,
  secure: false, // REQUIRED for TLS / STARTTLS
  auth: {
    user: 'info@bazutel.com',
    pass: process.env.EMAIL_PASSWORD
  },
  tls: {
    rejectUnauthorized: false
  },
  connectionTimeout: 20000,
  greetingTimeout: 20000,
  socketTimeout: 20000
});

// Verify SMTP
transporter.verify((err, success) => {
  if (err) {
    console.error('SMTP VERIFY ERROR:', err);
  } else {
    console.log('SMTP READY – Host accepted connection');
  }
});


// Verify SMTP connection-- this is working test
transporter.verify((err) => {
  if (err) {
    console.error('SMTP VERIFY ERROR:', err);
  } else {
    console.log('SMTP READY');
  }
});

// --- Apply Route ---
// Apply rate limiter BEFORE handling the file upload to avoid unnecessary uploads from blocked clients
router.post('/apply', applyLimiter, upload.single('cv'), async (req, res) => {
  try {
    const { fullName, phone, email, description, position } = req.body;

    if (!fullName || !email || !position || !req.file) {
      return res.status(400).json({ error: 'Missing fields' });
    }

    // Anti-spam: plain text, no extra formatting
    const emailText = `
New Job Application

Position: ${position}
Name: ${fullName}
Phone: ${phone || 'N/A'}
Email: ${email}

About Applicant:
${description}
    `;

    // Send email
    await transporter.sendMail({
      from: `"Bazu Careers" <${process.env.EMAIL_USER}>`,
      to: process.env.EMAIL_USER,
      replyTo: email,
      subject: `New Job Application – ${position}`,
      text: emailText,
      attachments: [
        {
          filename: req.file.originalname,
          content: req.file.buffer
        }
      ],
      envelope: {
        from: process.env.EMAIL_USER,
        to: process.env.EMAIL_USER
      }
    });

    res.json({ status: 'OK', message: 'Application sent successfully' });
  } catch (err) {
    console.error('EMAIL ERROR:', err);
    res.status(500).json({ error: 'Failed to send application' });
  }
});

export default router;
