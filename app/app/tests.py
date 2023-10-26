"""
Sample tests
"""
from django.test import SimpleTestCase
from app.calc import add, sub


class CalcTests(SimpleTestCase):
    """Test the calc module"""
    def test_add_numbers(self):
        """Test adding numbers together"""
        res = add(2, 5)
        expect = 7
        self.assertEqual(res, expect, "Message")

    def test_sub_numbers(self):
        """Test subtracting numbers together"""
        res = sub(3, 5)
        expect = -2
        self.assertEqual(res, expect, "Message")
