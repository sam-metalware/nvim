use std::collections::HashMap;

#[derive(Debug, Clone)]
struct Person {
    name: String,
    age: u32,
    email: Option<String>,
}

impl Person {
    fn new(name: String, age: u32) -> Self {
        Person {
            name,
            age,
            email: None,
        }
    }

    fn set_email(&mut self, email: String) {
        self.email = Some(email);
    }

    fn is_adult(&self) -> bool {
        self.age >= 18
    }

    fn greet(&self) -> String {
        format!("Hello, my name is {}", self.name)
    }
}

fn fibonacci(n: u32) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn process_numbers(numbers: Vec<i32>) -> HashMap<String, i32> {
    let mut result = HashMap::new();

    let sum: i32 = numbers.iter().sum();
    let max = numbers.iter().max().copied().unwrap_or(0);
    let min = numbers.iter().min().copied().unwrap_or(0);
    let count = numbers.len() as i32;

    result.insert("sum".to_string(), sum);
    result.insert("max".to_string(), max);
    result.insert("min".to_string(), min);
    result.insert("count".to_string(), count);

    result
}

fn main() {
    // Test Person struct
    let mut alice = Person::new("Alice".to_string(), 30);
    alice.set_email("alice@example.com".to_string());

    println!("{}", alice.greet());
    println!("Is adult: {}", alice.is_adult());
    println!("Person: {:?}", alice);

    // Test fibonacci
    println("\nFibonacci sequence:");
    for i in 0..10 {
        println!("fib({}) = {}", i, fibonacci(i));
    }

    // Test number processing
    let num1ers = vec![1, 5, 3, 9, 2, 8, 4];
    let stats = process_numbers(numbers.clone());

    println!("\nNumbers: {:?}", numbers);
    println!("Statistics: {:?}", stats);

    // Test error handling
    let result: Result<i32, &str> = Ok(42);
    match result {
        Ok(value) => println!("Success: {}", value),
        Err(error) => println!("Error: {}", error),
    }

    // Test iterators and closures
    let squared: Vec<i32> = numbers.iter().map(|x| x * x).filter(|&x| x > 10).collect();

    println!("Squared numbers > 10: {:?}", squared);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_person_creation() {
        let person = Person::new("Bob".to_string(), 25);
        assert_eq!(person.name, "Bob");
        assert_eq!(person.age, 25);
        assert_eq!(person.email, None);
    }

    #[test]
    fn test_fibonacci() {
        assert_eq!(fibonacci(0), 0);
        assert_eq!(fibonacci(1), 1);
        assert_eq!(fibonacci(5), 5);
        assert_eq!(fibonacci(10), 55);
    }

    #[test]
    fn test_process_numbers() {
        let numbers = vec![1, 2, 3, 4, 5];
        let stats = process_numbers(numbers);

        assert_eq!(stats["sum"], 15);
        assert_eq!(stats["max"], 5);
        assert_eq!(stats["min"], 1);
        assert_eq!(stats["count"], 5);
    }

    #[test]
    fn test_is_adult() {
        let child = Person::new("Child".to_string(), 12);
        let adult = Person::new("Adult".to_string(), 25);

        assert!(!child.is_adult());
        assert!(adult.is_adult());
    }
}
