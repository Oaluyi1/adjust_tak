import unittest
from app.app import app


class TestApp(unittest.TestCase):
    def setUp(self):
        self.tester = app.test_client()

    def test_hello_world(self):
        response = self.tester.get('/hello')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"message": "Hello World"})

    def test_health_check(self):
        response = self.tester.get('/health')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"status": "healthy"})


if __name__ == '__main__':
    unittest.main()
