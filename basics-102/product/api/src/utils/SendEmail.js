import nodemailer from 'nodemailer'

const sendEmail = async options => {
  // 1) Create a Transporter
  const transporter = nodemailer.createTransport({
    host: process.env.EMAIL_HOST,
    port: process.email.EMAIL_PORT,
    auth: {
      user: process.env.EMAIL_USERNAME,
      password: process.env.EMAIL_PASSWORD
    }
  })

  // 2) Define the email Options
  const mailOptions = {
    from: 'himanshu@local.email',
    to: options.email,
    subject: options.subject,
    text: options.message
  }

  // 3) Send the E-mail
  await transporter.sendMail(mailOptions)
}

export default sendEmail