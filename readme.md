# react-native-battery-status-ios

This is a wrapper for react-native that gives the battery status of a device. The options are get level (returns percent) or turn off battery monitoring. This is for ios only.

# Add it to your project

npm install react-native-battery-status-ios --save

In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name]

Go to node_modules ➜ react-native-battery-status-ios and add RNBatteryStatus.xcodeproj

In XCode, in the project navigator, select your project. Add libRNBatteryStatus.a to your project's Build Phases ➜ Link Binary With Libraries

Click RNBatteryStatus.xcodeproj in the project navigator and go the Build Settings tab. Make sure 'All' is toggled on (instead of 'Basic'). Look for Header Search Paths and make sure it contains both $(SRCROOT)/../react-native/React and $(SRCROOT)/../../React - mark both as recursive.

Run your project (Cmd+R)

Setup trouble?

If you get stuck, take a look at Brent Vatne's blog. His blog is my go to reference for this stuff.

# Api Setup

```javascript
var React = require('react-native');

var { NativeModules } = React;

var { RNBatteryStatus } = NativeModules;

RNBatteryStatus.batteryStatus(
    "getLevel", // getLevel, turnOff

    function errorCallback(results) {
        console.log('JS Error: ' + results['errMsg']);
    },

    function successCallback(results) {
        console.log('JS Success: ' + results['successMsg']);
    }
);
```

# Additional Notes

Calling "getLevel" automatically turns on battery monitoring (if it was turned off). The results['successMsg'] for the typical use-case will return a string that includes the percent level (eg. 32.00002). You can parse the string in JavaScript to use the value in your code.

# Error Callback

The following will cause an error callback (use the console.log to see the specific message):

1) Parameter not "getLevel" or "turnOff"

2) The device is plugged in.

3) Battery level is unknown. This could result from running in the simulator or because battery monitoring has been turned off.

# Acknowledgements

Special thanks to Brent Vatne for his posts on creating a react native packager. Some portions of this code have been based on answers from stackoverflow. This package also owes a special thanks to the tutorial by Jay Garcia at Modus Create on how to create a custom react native module.
