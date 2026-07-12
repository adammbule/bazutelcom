<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST");

$fullName   = $_POST["fullName"] ?? "";
$phone      = $_POST["phone"] ?? "";
$email      = $_POST["email"] ?? "";
$description = $_POST["description"] ?? "";
$position   = $_POST["position"] ?? "";
$cvName     = $_POST["cvName"] ?? "";
$cvBytes    = $_POST["cvBytes"] ?? "";

// Decode CV
$cvData = base64_decode($cvBytes);
$tmpFile = "/tmp/" . uniqid() . "_" . $cvName;

file_put_contents($tmpFile, $cvData);

// --- Email Setup ---
$to = "info@bazutel.com";
$subject = "New Job Application – $position";

$boundary = md5(time());

$headers = "From: careers@bazutel.com\r\n";
$headers .= "Reply-To: $email\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: multipart/mixed; boundary=\"$boundary\"";

// Email Body
$message = "--$boundary\r\n";
$message .= "Content-Type: text/plain; charset=UTF-8\r\n\r\n";

$message .= "
A new job application has been submitted:

Name: $fullName
Phone: $phone
Email: $email
Position: $position

About the applicant:
$description
";

// Attach CV
$cvContent = chunk_split(base64_encode($cvData));

$message .= "\r\n--$boundary\r\n";
$message .= "Content-Type: application/octet-stream; name=\"$cvName\"\r\n";
$message .= "Content-Transfer-Encoding: base64\r\n";
$message .= "Content-Disposition: attachment; filename=\"$cvName\"\r\n\r\n";
$message .= "$cvContent\r\n";
$message .= "--$boundary--";

// Send Email
$mailSent = mail($to, $subject, $message, $headers);

if ($mailSent) {
    echo "OK";
} else {
    echo "ERROR";
}

unlink($tmpFile);
?>
