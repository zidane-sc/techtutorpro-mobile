#!/bin/bash

# TechTutor Pro Development Setup Script
# This script helps set up the development environment for TechTutor Pro

set -e

echo "🚀 Setting up TechTutor Pro development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
check_flutter() {
    print_status "Checking Flutter installation..."
    if command -v flutter &> /dev/null; then
        FLUTTER_VERSION=$(flutter --version | head -n 1)
        print_success "Flutter is installed: $FLUTTER_VERSION"
    else
        print_error "Flutter is not installed. Please install Flutter first."
        print_status "Visit: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
}

# Check Flutter version
check_flutter_version() {
    print_status "Checking Flutter version..."
    FLUTTER_VERSION=$(flutter --version | grep -o 'Flutter [0-9]\+\.[0-9]\+\.[0-9]\+' | cut -d' ' -f2)
    REQUIRED_VERSION="3.3.1"
    
    if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$FLUTTER_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
        print_success "Flutter version $FLUTTER_VERSION meets requirements (>= $REQUIRED_VERSION)"
    else
        print_warning "Flutter version $FLUTTER_VERSION is below recommended version $REQUIRED_VERSION"
        print_status "Consider updating Flutter for best compatibility"
    fi
}

# Install dependencies
install_dependencies() {
    print_status "Installing Flutter dependencies..."
    flutter pub get
    print_success "Dependencies installed successfully"
}

# Generate code
generate_code() {
    print_status "Generating code with build_runner..."
    flutter packages pub run build_runner build --delete-conflicting-outputs
    print_success "Code generation completed"
}

# Run tests
run_tests() {
    print_status "Running tests..."
    flutter test
    print_success "All tests passed!"
}

# Analyze code
analyze_code() {
    print_status "Analyzing code..."
    flutter analyze
    print_success "Code analysis completed"
}

# Format code
format_code() {
    print_status "Formatting code..."
    dart format .
    print_success "Code formatting completed"
}

# Check if running on CI
if [ "$CI" = "true" ]; then
    print_warning "Running in CI environment, skipping interactive prompts"
    CI_MODE=true
else
    CI_MODE=false
fi

# Main setup process
main() {
    echo "🎓 TechTutor Pro Development Setup"
    echo "=================================="
    
    # Check prerequisites
    check_flutter
    check_flutter_version
    
    # Install dependencies
    install_dependencies
    
    # Generate code
    generate_code
    
    # Run analysis and tests
    analyze_code
    format_code
    
    if [ "$CI_MODE" = false ]; then
        echo ""
        read -p "Do you want to run tests? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            run_tests
        fi
    else
        run_tests
    fi
    
    echo ""
    print_success "🎉 Development environment setup completed!"
    echo ""
    echo "Next steps:"
    echo "1. Open the project in your IDE"
    echo "2. Run 'flutter run' to start the app"
    echo "3. Check the README.md for more information"
    echo "4. Read CONTRIBUTING.md for contribution guidelines"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@" 