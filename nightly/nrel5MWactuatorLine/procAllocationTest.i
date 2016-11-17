Simulations:
  - name: sim1
    time_integrator: ti_1
    optimizer: opt1

linear_solvers:

  - name: solve_scalar
    type: tpetra
    method: gmres
    preconditioner: sgs 
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0

  - name: solve_cont
    type: tpetra
    method: gmres 
    preconditioner: muelu 
    tolerance: 1e-5
    max_iterations: 50
    kspace: 50
    output_level: 0
    muelu_xml_file_name: milestone.xml
    summarize_muelu_timer: no

realms:

  - name: realm_1
    mesh: nrel5MWactuatorLine.g
    use_edges: no 
    automatic_decomposition_type: rcb

    equation_systems:
      name: theEqSys
      max_iterations: 2 
  
      solver_system_specification:
        velocity: solve_scalar
        pressure: solve_cont
   
      systems:

        - LowMachEOM:
            name: myLowMach
            max_iterations: 1
            convergence_tolerance: 1e-5

    initial_conditions:

      - constant: ic_1
        target_name: Unspecified-2-HEX
        value:
          pressure: 0.0
          velocity: [0.0,0.0,0.0]

    material_properties:
      target_name: Unspecified-2-HEX
      specifications:
        - name: density
          type: constant
          value: 1.0

        - name: viscosity
          type: constant
          value: 1.8e-2

    boundary_conditions:

    - inflow_boundary_condition: bc_1
      target_name: inflow
      inflow_user_data:
        velocity: [0.0,0.0,0.0]

    - open_boundary_condition: bc_2
      target_name: outflow
      open_user_data:
        pressure: 0.0
        velocity: [0.0,0.0,0.0]

    - wall_boundary_condition: bc_3
      target_name: left
      wall_user_data:
        velocity: [0.0,0.0,0.0]

    - wall_boundary_condition: bc_4
      target_name: right
      wall_user_data:
        velocity: [0.0,0.0,0.0]

    - wall_boundary_condition: bc_5
      target_name: bottom
      wall_user_data:
        velocity: [0.0,0.0,0.0]

    - wall_boundary_condition: bc_6
      target_name: top
      wall_user_data:
        velocity: [0.0,0.0,0.0]

    solution_options:
      name: myOptions

      options:

        - hybrid_factor:
            velocity: 1.0

        - limiter:
            pressure: no
            velocity: no

        - projected_nodal_gradient:
            pressure: element
            velocity: element 

        - source_terms:
            momentum: actuator_line

    actuator_line:
      search_method: boost_rtree
      search_target_part: Unspecified-2-HEX

      n_turbines_glob: 20
      dry_run:  True
      tMax:    0.0025
      n_every_checkpoint: 1
      
      Turbine0:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  1
        turbine_name: machine_zero
      
      Turbine1:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  2
        turbine_name: machine_one
      
      Turbine2:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  3
        turbine_name: machine_two
      
      Turbine3:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  4
        turbine_name: machine_three
      
      Turbine4:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  5
        turbine_name: machine_four
      
      Turbine5:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  6
        turbine_name: machine_five
      
      Turbine6:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  7
        turbine_name: machine_six
      
      Turbine7:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  8
        turbine_name: machine_seven
      
      Turbine8:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  9
        turbine_name: machine_eight
      
      Turbine9:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  10
        turbine_name: machine_nine
      
      Turbine10:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  11
        turbine_name: machine_ten
      
      Turbine11:
        procNo: 2
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  12
        turbine_name: machine_eleven
      
      Turbine12:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  13
        turbine_name: machine_twelve
      
      Turbine13:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  14
        turbine_name: machine_thirteen
      
      Turbine14:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  15
        turbine_name: machine_fourteen
      
      Turbine15:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  16
        turbine_name: machine_fifteen
      
      Turbine16:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  17
        turbine_name: machine_sixteen
      
      Turbine17:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  18
        turbine_name: machine_seventeen
      
      Turbine18:
        procNo: 0
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  19
        turbine_name: machine_eighteen
      
      Turbine19:
        procNo: 1
        gaussian_decay_radius: 10.0 
        gaussian_decay_target: 0.01
        turbine_pos: [ 0.0, 0.0, 0.0 ]
        restart_filename: "blah"
        FAST_input_filename: "banana.fst"
        turb_id:  20
        turbine_name: machine_nineteen

    output:
      output_data_base_name: actuatorLine.e
      output_frequency: 1
      output_node_set: no 
      output_variables:
       - velocity
       - pressure
       - actuator_line_source

Time_Integrators:
  - StandardTimeIntegrator:
      name: ti_1
      start_time: 0
      termination_step_count: 1
      time_step: 0.0025
      time_stepping_type: fixed
      time_step_count: 0
      second_order_accuracy: no

      realms:
        - realm_1
