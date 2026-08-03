(* TRANSCRIPTION — this is NOT the ifc_check library. See
   tools/precompile_stubs/README.md. Consumed only by
   tools/precompile_check.sh lane 2. Never linked, never run.

   SOURCE
     docs/specs/ifc_check/axi64_ifc.ml — the lift of SPEC-M01 §4.1, committed
     in this repository and countersigned at 22145b5. The record modules below
     carry that file's field NAMES in that file's ORDER. The [@bits] width
     attributes and [@@deriving hardcaml] are deliberately dropped: they
     generate ports and widths, and neither is a type a DV file names.

   VERIFIED
     Mechanically, by precompile_check.sh lane 2b, on EVERY run: the source is
     committed in this repository, so the field-name comparison for
       Xgmii  Eth_header  Ip_header  Udp_header  Config  Status
     can never be skipped. A drift between this file and the lift fails the
     harness.

   NOT RE-CHECKABLE BY THIS HARNESS — a limit of this tool, NOT an open
   programme gap. The distinction is the correction below.
     [Axi64.Source] and [Axi64.Dest] are NOT in the lift. The lift writes
       module Axi64 = Hardcaml_axi.Stream.Make (Axi64_config)
     so their field names come from hardcaml_axi v0.17.0's stream_intf.ml.
     hardcaml_axi's sources are not present in this container, so lane 2b
     cannot re-check these six names and says so. They are settled by the
     real CI build of test/axi64_probe/, not here.

   CORRECTION (J-dv_lead-0049, on architect_docs_lead's return). Until now
   this section read that SPEC-M01 §11.4 "already records" these names as
   "transcribed and unverified by compilation", and cited that as support.
   That citation was wrong, and wrong from the moment it was written:
     - §11.4's **Status** has read CLOSED (WO-0010, CI run 30729342467)
       since f78766e — the freeze SHA itself. The sentence I quoted is the
       row's permanent **Item** cell, which states the ORIGINAL problem and
       never changes; I read the Item column as though it were the Status
       column, so the note was stale on the day it was committed rather
       than going stale later.
     - CI run 30769770945 is a CORROBORATION of that closure by SITE
       INDEPENDENCE — bench.ml is an instantiated-DUT site outside the file
       family that transcribed the names — and not a first discharge.
   Nothing above this correction changes in substance: lane 2b still cannot
   re-check these six names in this container. What changes is that the
   limit is THIS HARNESS's, and must not be dressed as a standing programme
   acknowledgement by citing a ledger row that is closed.

   SCOPE
     Types only. No values, so nothing here can be executed; a DV file that
     needs a generated function (map, iter, port_names_and_widths, …) gets
     "Unbound value" from lane 2, which is the intended behaviour. *)

module Axi64_ifc = struct
  (* Widths, from the lift's [Axi64_config]. Present so the name resolves;
     nothing in DV reads them. *)
  module Axi64_config = struct
    let data_bits = 64
    let user_bits = 1
  end

  (* NOT from the lift — see "UNVERIFIED" above. hardcaml_axi v0.17.0's
     [Stream.Make] yields these two records. *)
  module Axi64 = struct
    module Source = struct
      type 'a t =
        { tvalid : 'a
        ; tdata : 'a
        ; tkeep : 'a
        ; tstrb : 'a
        ; tlast : 'a
        ; tuser : 'a
        }
    end

    module Dest = struct
      type 'a t = { tready : 'a }
    end
  end

  (* All six records below are the lift's, field for field. *)
  module Xgmii = struct
    type 'a t =
      { d : 'a
      ; c : 'a
      }
  end

  module Eth_header = struct
    type 'a t =
      { valid : 'a
      ; dst_mac : 'a
      ; src_mac : 'a
      ; ethertype : 'a
      }
  end

  module Ip_header = struct
    type 'a t =
      { valid : 'a
      ; src_ip : 'a
      ; dst_ip : 'a
      ; protocol : 'a
      ; ttl : 'a
      ; dscp : 'a
      ; total_length : 'a
      }
  end

  module Udp_header = struct
    type 'a t =
      { valid : 'a
      ; src_port : 'a
      ; dst_port : 'a
      ; length : 'a
      ; checksum : 'a
      }
  end

  module Config = struct
    type 'a t =
      { local_mac : 'a
      ; local_ip : 'a
      ; subnet_mask : 'a
      ; gateway_ip : 'a
      ; multicast_group : 'a
      ; multicast_enable : 'a
      ; listen_port : 'a
      ; accept_all_ports : 'a
      ; ttl : 'a
      ; ifg : 'a
      ; rx_enable : 'a
      ; tx_enable : 'a
      }
  end

  module Status = struct
    type 'a t =
      { error_bad_fcs : 'a
      ; error_bad_frame : 'a
      ; error_runt : 'a
      ; error_oversize : 'a
      ; error_start_without_terminate : 'a
      ; error_underflow : 'a
      ; error_short_frame : 'a
      ; error_unknown_ethertype : 'a
      ; error_arp_unsupported : 'a
      ; error_arp_miss : 'a
      ; error_arp_reply_dropped : 'a
      ; error_ip_bad_header : 'a
      ; error_ip_bad_checksum : 'a
      ; error_ip_fragment : 'a
      ; error_ip_not_for_us : 'a
      ; error_ip_truncated : 'a
      ; error_ip_bad_protocol : 'a
      ; error_ip_oversize : 'a
      ; error_udp_bad_length : 'a
      ; error_udp_port : 'a
      ; error_tx_length_mismatch : 'a
      }
  end
end
