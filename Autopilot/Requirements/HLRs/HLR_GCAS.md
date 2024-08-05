
# High-Level Requirements for Ground Collision Avoidance System (GCAS)

 - **GCAS-001:** The GCAS component shall provide a procedure to reset its internal state to ensure proper initialization and recovery from errors.

 - **GCAS-002:** The GCAS component shall detect potential ground collisions by continuously monitoring the aircraft's altitude, vertical speed, horizontal speed, and terrain elevation data.

 - **GCAS-003:** The GCAS component shall implement an algorithm to predict potential collisions by evaluating future altitude projections against terrain elevations, accommodating both low-speed and normal-speed conditions.

 - **GCAS-004:** The GCAS component shall maintain and update its operational state, transitioning through predefined states (e.g., disengaged, emergency, recovery, stabilize) based on collision predictions and aircraft performance data.

 - **GCAS-005:** The GCAS component shall transition directly to an emergency state and initiate appropriate collision avoidance maneuvers upon predicting a collision.

 - **GCAS-006:** The GCAS component shall transition from an emergency state to a recovery state, then to a stabilized state, and finally to a disengaged state when safe conditions are re-established.

 - **GCAS-007:** The GCAS component shall operate in real-time, continuously updating its state and collision predictions based on the latest sensor data and flight conditions.

 - **GCAS-008:** The GCAS component shall autonomously manage collision avoidance, requiring no manual intervention once activated.

 - **GCAS-009:** The GCAS component shall integrate data from various sensors, including GPS for altitude and speed and terrain map data for elevation profiles, to ensure accurate collision predictions.

 - **GCAS-010:** The GCAS component shall interface with aircraft systems to receive necessary data inputs and provide state updates, ensuring seamless integration into the aircraft's avionics suite.

 - **GCAS-011:** The GCAS component shall define and use specific altitude thresholds (collision, emergency, recovery, stable) to determine the appropriate response to potential collision threats.

