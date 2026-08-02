(* requirements.md §12, in order. One name per line so that
   tools/check_records_vs_appendix.sh can extract them mechanically; do not
   reflow this list. *)

let all =
  [ "error_bad_fcs"
  ; "error_bad_frame"
  ; "error_runt"
  ; "error_oversize"
  ; "error_start_without_terminate"
  ; "error_underflow"
  ; "error_short_frame"
  ; "error_unknown_ethertype"
  ; "error_arp_unsupported"
  ; "error_arp_miss"
  ; "error_arp_reply_dropped"
  ; "error_ip_bad_header"
  ; "error_ip_bad_checksum"
  ; "error_ip_fragment"
  ; "error_ip_not_for_us"
  ; "error_ip_truncated"
  ; "error_ip_bad_protocol"
  ; "error_ip_oversize"
  ; "error_udp_bad_length"
  ; "error_udp_port"
  ; "error_tx_length_mismatch"
  ]
;;

let count = List.length all
let mem name = List.exists (fun s -> String.equal s name) all
