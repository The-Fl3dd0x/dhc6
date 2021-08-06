########## Global Initial #########
props.globals.initNode("/sim/rendering/als-secondary-lights/landing-light1-offset-deg",-1);
props.globals.initNode("/systems/electrical/outputs/landing-light",0.0);
props.globals.initNode("/systems/electrical/outputs/taxi-light",0.0);
###################################

var als_taxi_light = func {

    var landing_light_output = getprop("/systems/electrical/outputs/landing-light");
    var taxi_light_output = getprop("/systems/electrical/outputs/taxi-light");

    var taxi_light_on = (taxi_light_output > 20.0 and taxi_light_output < 31.5);

    var left_landing_light_off = (landing_light_output <= 20.0 or landing_light_output >= 31.5);

    if (taxi_light_on and left_landing_light_off) {
        setprop("/sim/rendering/als-secondary-lights/landing-light1-offset-deg",-1);
    } else {
        setprop("/sim/rendering/als-secondary-lights/landing-light1-offset-deg",-5);
    }
    
    settimer(als_taxi_light, 0.382);

}

setlistener("/sim/signals/fdm-initialized", als_taxi_light);