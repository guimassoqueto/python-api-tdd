"""
Tests for models.
"""
from decimal import Decimal
from core import models

from django.test import TestCase
from django.contrib.auth import get_user_model


class ModelTests(TestCase):
    """Test models."""
    def test_create_user_with_email_successful(self):
        """Test creating user with an email is successful."""
        email = "test_email@email.com"
        password = "password123"
        user = get_user_model().objects.create_user(
          email=email,
          password=password,
        )
        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        """Test email is normalized for new users."""
        sample_emails = [
          ['test1@EXAMPLE.com', 'test1@example.com'],
          ['Test2@Example.com', 'Test2@example.com'],
          ['TEST3@EXAMPLE.com', 'TEST3@example.com'],
          ['test4@example.COM', 'test4@example.com'],
        ]
        for email, expected in sample_emails:
            user = get_user_model().objects.create_user(
              email=email,
              password='password123'
            )
            self.assertEqual(user.email, expected)

    def test_new_user_without_email_raises_error(self):
        """
        Test that creating user without an email (empty field)
        raises a ValueError.
        """
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(
                email='',
                password='password123',
            )

    def test_create_superuser(self):
        """Test creating a superuser."""
        user = get_user_model().objects.create_superuser(
            email='superuser@email.com',
            password='password123'
        )
        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)

    def test_new_superuser_email_normalized(self):
        """Test email is normalized for new superusers."""
        sample_emails = [
          ['super1@EXAMPLE.com', 'super1@example.com'],
          ['Super2@Example.com', 'Super2@example.com'],
          ['SUPER3@EXAMPLE.com', 'SUPER3@example.com'],
          ['super4@example.COM', 'super4@example.com'],
        ]
        for email, expected in sample_emails:
            user = get_user_model().objects.create_superuser(
              email=email,
              password='password123'
            )
            self.assertEqual(user.email, expected)

    def test_new_superuser_without_email_raises_error(self):
        """
        Test that creating user without an email (empty field)
        raises a ValueError.
        """
        with self.assertRaises(ValueError):
            get_user_model().objects.create_superuser(
                email='',
                password='password123',
            )

    def test_create_recipe(self):
        """
        Test creating a recipe is sucessful.
        """
        user = get_user_model().objects.create_user(
            'test@example.com',
            'testpass123',
        )
        recipe = models.Recipe.objects.create(
            user=user,
            title='Sample recipe name',
            time_minutes=5,
            price=Decimal('5.50'),
            description='Sample recipe description',
        )
        self.assertEqual(str(recipe), recipe.title)
