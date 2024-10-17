open Screen

type parameters = {
  ambient_celcius: float;
  water_kg:float;
  heat_capacity_jkgc:float;
  power_watts: float;
  cooling_constant: float;
  time_step_seconds: float;
}

type state = {
  water_celcius: float;
  elapsed_time_seconds:float;
  heater_on:bool;
}

(* let round_to_decimals x n =
  let factor = 10. ** float_of_int n in
  floor (x *. factor +. 0.5) /. factor *)

let calculate_heating 
  (config: parameters )
  (temp_initial_celcius:float) 
  : float = 
  (* Power in Joules: P (in watts) * time (in seconds) *)
  let energy_added = config.power_watts *. config.time_step_seconds in
  (* ΔT = Q / (m * c) *)
  let delta_temp = energy_added /. (config.water_kg *. config.heat_capacity_jkgc) in
  temp_initial_celcius +. delta_temp

(* Function to calculate final temperature with cooling (Newton's Law of Cooling) *)
let calculate_cooling 
  (config: parameters)
  (temp_initial_celsius:float)
  :float =
  (* Newton's Law of Cooling: T(t) = T_ambient + (T_initial - T_ambient) * exp(-k * t) *)
  let temperature_difference = temp_initial_celsius -. config.ambient_celcius in
  let cooling_rate = -. config.cooling_constant *. config.time_step_seconds in
  config.ambient_celcius +. temperature_difference *. exp(cooling_rate)


(* Function to forecast temperature after 1 hour based on heating or cooling *)
let forecast_temperature 
  (config: parameters) 
  (temp_initial:float) 
  (is_heating:bool)
  :float =
  match is_heating with
  | true -> calculate_heating config temp_initial 
  | false -> calculate_cooling config temp_initial

let step_temperature (current_state: state) (p: parameters): state = 
  let new_temperature = forecast_temperature p current_state.water_celcius current_state.heater_on in
  let new_time = current_state.elapsed_time_seconds +. p.time_step_seconds in 
  {
    water_celcius = new_temperature;
    elapsed_time_seconds = new_time;
    heater_on = current_state.heater_on;
  }

let rec event_loop (current:state) (p: parameters) :state  =
  (* if ButtonA.is_on ()
    then print_string "ON"
    else print_string "OFF"; *)
  
  print_int @@ int_of_float current.water_celcius;

  match ButtonB.is_on () with
  | true -> let new_state = step_temperature current p in
    event_loop new_state p
  | false -> event_loop current p
  
let _ =
  let p:parameters = { 
    ambient_celcius = 25.0; 
    water_kg = 10.0; 
    heat_capacity_jkgc = 4186.0; 
    power_watts = 300.0; 
    cooling_constant = 0.01;
    time_step_seconds = 60.0;
    } in
  let initial:state = {
    water_celcius = 80.0;
    elapsed_time_seconds = 0.0;
    heater_on = true
  } in
  event_loop initial p