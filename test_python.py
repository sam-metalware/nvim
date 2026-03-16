from dataclasses import dataclass
from typing import Optional
import json


@dataclass
class Person:
    name: str
    age: int
    email: Optional[str] = None

    def is_adult(self) -> bool:
        return self.age >= 18

    def greet(self) -> str:
        return f"Hello, my name is {self.name}"


def fibonacci(n: int) -> int:
    if n <= 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)


def process_numbers(numbers: list[int]) -> dict[str, int]:
    return {
        "sum": sum(numbers),
        "max": max(numbers),
        "min": min(numbers),
        "count": len(numbers),
    }


def main():
    alice = Person("Alice", 30, "alice@example.com")
    bob = Person("Bob", 15)

    print(alice.greet())
    print(f"Is adult: {alice.is_adult()}")
    print(f"Bob adult: {bob.is_adult()}")

    print("\nFibonacci sequence:")
    for i in range(10):
        print(f"fib({i}) = {fibonacci(i)}")

    numbers = [1, 5, 3, 9, 2, 8, 4]
    stats = process_numbers(numbers)
    print(f"\nNumbers: {numbers}")
    print(f"Statistics: {json.dumps(stats, indent=2)}")


if __name__ == "__main__":
    main()
