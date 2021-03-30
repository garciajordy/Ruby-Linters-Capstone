# Ruby-Linters

In this project, I have implemented my own version of Linters using Ruby.

## Built With

- Ruby
- VS Code

## Getting Started

To get a local copy of the repository please run the following commands on your terminal:

```
$ cd <folder>
```

```
$ git clone https://github.com/garciajordy/Ruby-Linters-Capstone.git
```

## To Test For Linter Errors

> Copy your ruby file in the Ruby-Linters-Capstone folder

```
$ cd Ruby-Linters-Capstone
```

```
$ ruby bin/main.rb test.rb
```

> Change test.rb with any file you would like to check

## Good and Bad Examples

### **Indentation**

> Good Example

```
class Test
  def initialize(name)
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

> Bad Example

```
class Test
  def initialize(name)
@name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

### **White Trailing Space**

> Good Example

> I Used the pipe "|" on the second line to indicate the cursor

```
class Test
  def initialize(name)|
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

> Bad Example

```
class Test
  def initialize(name) |
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

### **Empty Line**

> Good Example

```
class Test
  def initialize(name)
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

> Bad Example

```
class Test
  def initialize(name)

    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

### **Unexpected END**

> Good Example

```
class Test
  def initialize(name)
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

> Bad Example

```
class Test
  def initialize(name)
@name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
end
```

### **Missing Closing Brackets**

> Good Example

```
class Test
  def initialize(name)
    @name = [name]
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

> Bad Example

```
class Test
  def initialize(name)
    @name = [name
    @age = name.length
  end

  def call_me
    puts "HEEEEY, #{@name}!!"
  end
end
```

## Author Details

👤 **Jordy Garcia**

- Github: [![](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/garciajordy/)
- Linkedin: [![](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jordy-garcia-675849206/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/garciajordy/Ruby-Linters-Capstone/issues).

## Show your support

Give ⭐ Star me on GitHub — it helps!
