{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "a93283ac",
   "metadata": {},
   "outputs": [],
   "source": [
    "<?php\n",
    "  /**\n",
    "  * Requires the \"PHP Email Form\" library\n",
    "  * The \"PHP Email Form\" library is available only in the pro version of the template\n",
    "  * The library should be uploaded to: vendor/php-email-form/php-email-form.php\n",
    "  * For more info and help: https://bootstrapmade.com/php-email-form/\n",
    "  */\n",
    "\n",
    "  // Replace contact@example.com with your real receiving email address\n",
    "  $receiving_email_address = 'contact@example.com';\n",
    "\n",
    "  if( file_exists($php_email_form = '../assets/vendor/php-email-form/php-email-form.php' )) {\n",
    "    include( $php_email_form );\n",
    "  } else {\n",
    "    die( 'Unable to load the \"PHP Email Form\" Library!');\n",
    "  }\n",
    "\n",
    "  $contact = new PHP_Email_Form;\n",
    "  $contact->ajax = true;\n",
    "  \n",
    "  $contact->to = $receiving_email_address;\n",
    "  $contact->from_name = $_POST['name'];\n",
    "  $contact->from_email = $_POST['email'];\n",
    "  $contact->subject = $_POST['subject'];\n",
    "\n",
    "  // Uncomment below code if you want to use SMTP to send emails. You need to enter your correct SMTP credentials\n",
    "  /*\n",
    "  $contact->smtp = array(\n",
    "    'host' => 'example.com',\n",
    "    'username' => 'example',\n",
    "    'password' => 'pass',\n",
    "    'port' => '587'\n",
    "  );\n",
    "  */\n",
    "\n",
    "  $contact->add_message( $_POST['name'], 'From');\n",
    "  $contact->add_message( $_POST['email'], 'Email');\n",
    "  $contact->add_message( $_POST['message'], 'Message', 10);\n",
    "\n",
    "  echo $contact->send();\n",
    "?>"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "mlenv",
   "language": "python",
   "name": "mlenv"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.8.8"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
