-- This is a threaded script
-- Here are our joint handles
joints={-1,-1,-1,-1,-1,-1,}
joints[1]=sim.getObjectHandle('J0')
joints[2]=sim.getObjectHandle('J1')
joints[3]=sim.getObjectHandle('J2')
joints[4]=sim.getObjectHandle('J3')
joints[5]=sim.getObjectHandle('J4')
joints[6]=sim.getObjectHandle('J5')

-- stop is used to halt the motion of all motors. The robot starts in stop position.
stop={0,0,0,0,0,0,0}
current_vel=stop
current_accel=stop
-- Set some of the RML vectors by converting to angular equivalent
vel=10
vel={vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180,vel*math.pi/180}
accel=40
accel={accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180,accel*math.pi/180}
jerk=80
jerk={jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180,jerk*math.pi/180}

-- Cheap & easy way to call the sim API without copying all this crap every time asdfqwerasdfzxcv
function move_to(target_vector)
    sim.rmlMoveToJointPositions(joints,sim.rml_phase_sync_if_possible,current_vel,current_accel,vel,accel,jerk,target_vector,stop)
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

-- Main thread of execution for this task
function sysCall_threadmain()
    rot_y1(90)
end
