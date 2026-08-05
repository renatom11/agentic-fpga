(* THROWAWAY — WO-0070 §1. Print-only, zero assertions. Measures the FIVE
   phases of a family-L stress run (WO-0070 §1.3) at three ascending sizes,
   flushing after each, so that if the process dies the log's last completed
   line names the largest size this runner survived.

   CPU time via Sys.time, not wall clock: a shared runner's descheduling must
   not move the figure. Peak heap via Gc.quick_stat, which does not walk the
   heap. Every line is prefixed COST-PROBE-L so it is greppable out of a
   build log. *)

let timed f =
  let t0 = Sys.time () in
  let v = f () in
  (Sys.time () -. t0, v)
;;

let cap_seconds = 300.0

let probe ~count =
  let t_schedule, sched = timed (fun () -> Dv_xgmii.Arrival.stress ~count ()) in
  let t_check, problems = timed (fun () -> Dv_xgmii.Arrival.check sched) in
  let t_elaborate, bench = timed (fun () -> Test_xgmii_rx_64.Bench.create ()) in
  let t_drive, samples =
    timed (fun () -> Test_xgmii_rx_64.Bench.run bench sched ~drain:8 ())
  in
  let t_account, (n_frames, n_words) =
    timed (fun () ->
      let frames = Dv_xgmii.Arrival.frames sched in
      let rest = ref (Test_xgmii_rx_64.Bench.delivered_samples samples) in
      let nf = ref 0 in
      let nw = ref 0 in
      Array.iter
        (fun f ->
          let group, remainder = Test_xgmii_rx_64.Bench.split_at_first_tlast !rest in
          rest := remainder;
          match group with
          | [] -> ()
          | _ :: _ ->
            nw := !nw + List.length group;
            incr nf;
            Test_xgmii_rx_64.Bench.account_clean_frame bench f group ~aborted:false)
        frames;
      (!nf, !nw))
  in
  let total = t_schedule +. t_check +. t_elaborate +. t_drive +. t_account in
  let heap = (Gc.quick_stat ()).Gc.top_heap_words in
  Printf.printf
    "COST-PROBE-L count=%d schedule=%.3f check=%.3f elaborate=%.3f drive=%.3f \
     account=%.3f total=%.3f cycles=%d dsamples=%d frames=%d top_heap_words=%d \
     schedule_problems=%d\n"
    count
    t_schedule
    t_check
    t_elaborate
    t_drive
    t_account
    total
    (Dv_xgmii.Arrival.cycles sched + 8)
    n_words
    n_frames
    heap
    (List.length problems);
  flush stdout;
  total
;;

let () =
  Printf.printf
    "COST-PROBE-L begin (THROWAWAY, WO-0070 §1; never committed to the working \
     branch)\n";
  flush stdout;
  let rec go acc = function
    | [] -> ()
    | count :: rest ->
      let t = probe ~count in
      let acc = acc +. t in
      if acc > cap_seconds
      then (
        Printf.printf
          "COST-PROBE-L abort after count=%d (cumulative %.3f s exceeds the %.0f s \
           self-cap)\n"
          count
          acc
          cap_seconds;
        flush stdout)
      else go acc rest
  in
  go 0.0 [ 100; 1_000; 10_000 ];
  Printf.printf "COST-PROBE-L end\n";
  flush stdout
;;
