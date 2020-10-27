-- This is a threaded script

-- ----------------------------------------------------------------------------
-- GLOBAL ARM-SPECIFIC VARIABLES
-- ---------------------------------------------------------------------------
-- Set the RML vectors by converting meters/second to angular equivalent (the lists are to specify values for each joint
w = math.pi/180
v = 10 * w
vel = {v, v, v, v, v, v}
a = 40 * w
accel = {a, a, a, a, a, a}
j = 80 * w
jerk = {j, j, j, j, j, j}

-- ----------------------------------------------------------------------------
-- ARM JOINT SETUP
-- ----------------------------------------------------------------------------
joints = {-1, -1, -1, -1, -1, -1}
joints[1] = sim.getObjectHandle('J0')
joints[2] = sim.getObjectHandle('J1')
joints[3] = sim.getObjectHandle('J2')
joints[4] = sim.getObjectHandle('J3')
joints[5] = sim.getObjectHandle('J4')
joints[6] = sim.getObjectHandle('J5')

-- stop is used to halt the motion of all motors. The robot starts in stop position.
stop_arm = {0, 0, 0, 0, 0, 0}
arm_vel = stop_arm
arm_accel = stop_arm

-- ----------------------------------------------------------------------------
-- ARM JOINT API METHODS
-- ----------------------------------------------------------------------------
-- Cheap & easy way to call the sim API without copying all this crap every time asdfqwerasdfzxcv
function move_to(target_vector)
    sim.rmlMoveToJointPositions(joints,sim.rml_phase_sync_if_possible,current_vel,current_accel,vel,accel,jerk,target_vector,stop_arm)
end

-- Return to the origin upright position
function origin()
    move_to({0,0,0,0,0,0})
end
-- rot_[a][n]: Rotate the nth motor from the bottom (which rotates about axis 'a') to a target position in degrees
function rot_z1(target)
    move_to({target*math.pi/180,0,0,0,0,0})
end
function rot_z2(target)
    move_to({0,0,0,target*math.pi/180,0,0})
end
function rot_z3(target)
    move_to({0,0,0,0,0,target*math.pi/180})
end
function rot_x1(target)
    move_to({0,target*math.pi/180,0,0,0,0})
end
function rot_x2(target)
    move_to({0,0,target*math.pi/180,0,0,0})
end
function rot_y1(target)
    move_to({0,0,0,0,target*math.pi/180,0})
end

-- HAND API SETUP
fingers = {-1,-1,-1,-1}
fingers[1] = sim.getObjectHandle('LEFT_BOTTOM')
fingers[2] = sim.getObjectHandle('LEFT_TIP')
fingers[3] = sim.getObjectHandle('RIGHT_BOTTOM')
fingers[4] = sim.getObjectHandle('RIGHT_TIP')

stop_hand = {0, 0, 0, 0}
hand_vel = stop_hand
hand_accel = stop_hand

function close_hand()
    sim.rmlMoveToJointPositions(fingers,sim.rml_phase_sync_if_possible,current_vel,current_accel,vel,accel,stop_hand,stop_hand)
end

-- Main thread of execution for this task
function sysCall_threadmain()
    rot_y1(90)
	origin()
end
