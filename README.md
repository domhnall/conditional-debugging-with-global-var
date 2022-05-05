# Using ruby global variables to laser-focus tests

This small repo is intended to act as a demonstration of a simple
technique using global variables to aid with debugging.

In this example we are debugging a test file, but the same principle can
be used for general debugging.

I don't use this frequently, but in certain cases it can be a real
time-saver.

To see run the test file:

> rspec spec/user_spec.rb    # One test will fail

To see the technique, toggle the lines which are commented in the last
test in `user_spec.rb` file.

This time the debugger will break into the relevant source method, at
the precise invocation that is causing problems.

Please refer to the [blog
article](https://www.vector-logic.com/blog/posts) for a more detailed
discussion on this technique.
