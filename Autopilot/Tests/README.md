
# Example component test

The component test is written in Ada. For example (test001):

<pre>
tests.configure ("Climb", AFDS => True, GCAS => True, NAV => False);

 -- set aircraft initial state
 FDM.set (latitude => 0.0,
          longitude => 0.0,
          altitude => 2000.0,
          heading => 0.0,
          velocity => 300.0
         );

 -- set AFDS configuration
 nav_interface.set_heading (0.0);
 nav_interface.set_altitude (4000.0);
 nav_interface.set_velocity (300.0);

 -- run for 120 seconds
 tests.run_seconds (120);

 -- check aircraft state
 tests.check ("Altitude", Float(aircraft.status.altitude), 4000.0, 100.0);
 tests.check ("Velocity", Float(aircraft.status.velocity), 300.0,  10.0);
 tests.check ("Heading" , Float(aircraft.status.heading),  0.0,    3.0);
</pre>



# Example output of the execution of the component tests.


<pre>
-----------------------
Starting test 1
TEST 'Climb'
Target altitude:4000.000
Target velocity:300.000
Checked Altitude: OK
Checked Velocity: OK
Checked Heading: OK
Test 1: OK
-----------------------
Starting test 2
TEST 'Heading change'
Target heading:180.000
Target altitude:2000.000
Target velocity:300.000
Checked Altitude: OK
Checked Velocity: OK
Checked Heading: OK
Test 2: OK
-----------------------
Starting test 3
TEST 'Accelerate'
Target altitude:2000.000
Target velocity:400.000
Checked Altitude: OK
Checked Velocity: OK
Checked Heading: OK
Test 3: OK
-----------------------
Starting test 4
TEST 'Climb, turn and accelerate'
Target heading:130.000
Target altitude:4000.000
Target velocity:450.000
Checked Altitude: OK
Checked Velocity: OK
Checked Heading: OK
Test 4: OK
-----------------------
Starting test 5
TEST 'GCAS'
Target heading:150.000
Target velocity:450.000
GCAS: emergency
Checked GCAS emergency: OK
Checked Altitude: OK
GCAS: recovery
Checked GCAS recovery: OK
Checked Vertical Speed: OK
GCAS: stabilize
Checked GCAS stabilize: OK
Checked Altitude: OK
GCAS: disengaged
Checked GCAS disengaged: OK
Test 5: OK
-----------------------
Starting test 6
TEST 'NAV + AFDS'
Target heading:90.000
Target altitude:4000.000
Target velocity:300.000
Target heading:90.0501
Target heading:91.0014
Target heading:91.0515
Target heading:92.0015
Target heading:92.0515
Target heading:93.0017
Target heading:93.0520
Target heading:93.003
Target heading:92.0485
Checked Waypoint 1 reached: OK
Target heading:0.0475
Target heading:359.1000
Target heading:359.0491
Target heading:358.0991
Target heading:358.0491
Target heading:358.0991
Target heading:359.0492
Target heading:358.0989
Target heading:358.0485
Target heading:358.0988
Target heading:359.0490
Checked Waypoint 2 reached: OK
Target heading:359.0999
Target heading:0.000
Checked Waypoint 3 reached: OK
Target heading:134.0751
Target heading:135.0260
Target heading:135.0761
Target heading:135.0261
Target heading:134.0759
Target heading:134.0259
Target heading:134.0763
Target heading:135.0274
Target heading:135.0782
Checked Waypoint 4 reached: OK
Target heading:243.0292
Target heading:243.0794
Target heading:244.0294
Target heading:244.0794
Target heading:244.0294
Target heading:243.0794
Target heading:244.0295
Target heading:244.0798
Target heading:244.0297
Target heading:243.0766
Checked Waypoint 5 reached: OK
Test 6: OK
-----------------------
--    TEST SUMMARY   --
-----------------------
Test 1: OK
Test 2: OK
Test 3: OK
Test 4: OK
Test 5: OK
Test 6: OK
</pre>