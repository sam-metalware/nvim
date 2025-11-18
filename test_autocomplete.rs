// Regular comment at top of file
// This tests comment highlighting

/// Doc comment for the Person struct
/// This should be dark grey
#[derive(Debug, Clone)]
struct Person {
    name: String,
    age: u32,
    email: String,
}

impl Person {
    /// Doc comment for new function
    fn new(name: String, age: u32, email: String) -> Self {
        // Regular comment inside function
        Person { name, age, email }
    }

    /// Doc comment for greet method
    fn greet(&self) -> String {
        // Another regular comment
        format!(
            "Hello, my name is {} and I'm {} years old.",
            self.name, self.age
        )
    }

    // Comment on is_adult
    fn is_adult(&self) -> bool {
        // Comment inside is_adult function
        self.age >= 18
    }
}

fn main() {
    // Regular comment - test struct
    let person = Person::new("Alice".to_string(), 30, "alice@example.com".to_string());

    // Another comment - test method
    println!("{}", person.greet());
    println!("Is adult: {}", person.is_adult());

    // Test with Vec
    let mut numbers = vec![1, 2, 3, 4, 5];
    numbers.push(6);
    numbers.iter().for_each(|n| print!("{} ", n));
    println!();

    // Test HashMap
    let mut map = HashMap::new();
    map.insert("key1", "value1");
    map.insert("key2", "value2");

    // Pattern matching test
    match map.get("key1") {
        Some(value) => println!("Found: {}", value),
        None => println!("Not found"),
    }

    // Result handling test
    let result = divide(10.0, 2.0);
    match result {
        Ok(value) => println!("Result: {}", value),
        Err(e) => println!("Error: {}", e),
    }

    // Closure test
    let add_one = |x: i32| x + 1;
    println!("5 + 1 = {}", add_one(5));

    // Iterator methods test
    let filtered: Vec<_> = numbers
        .iter()
        .filter(|&&x| x % 2 == 0)
        .map(|&x| x * 2)
        .collect();
    println!("Filtered and doubled: {:?}", filtered);
}

/// Doc comment for divide function
/// Returns a Result with the division or an error
fn divide(a: f64, b: f64) -> Result<f64, String> {
    // Check for division by zero
    if b == 0.0 {
        Err("Division by zero".to_string())
    } else {
        // Return the result
        Ok(a / b)
    }
}
