type parameters = {
  ambient_celcius: float;
  water_kg:float;
  heat_capacity_jkgc:float;
  power_watts: float;
  cooling_constant: float;
  time_step_seconds: float;
}

(* type controller_config = {
  heat_threshold_celcius: float;
  cold_threshold_celcius: float;
} *)

type state = {
  water_celcius: float;
  elapsed_time_seconds:float;
  heater_on:bool;
  (* switch_heater_status: bool; *)
}