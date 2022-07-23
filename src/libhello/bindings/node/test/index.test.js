const H = require('hello');

test('Greeting works as expected', () => {
    const greeter = new H.Greeter("Test");
    expect(greeter.greet()).toBe("Hello Test");
});
