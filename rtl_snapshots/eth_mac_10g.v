module crc32_eth (
    data,
    crc_in,
    octet_count,
    crc_out
);

    input [63:0] data;
    input [31:0] crc_in;
    input [3:0] octet_count;
    output [31:0] crc_out;

    wire [31:0] _584;
    wire _582;
    wire _581;
    wire _583;
    wire [31:0] _585;
    wire _574;
    wire _573;
    wire _575;
    wire [31:0] _577;
    wire _566;
    wire _565;
    wire _567;
    wire [31:0] _569;
    wire _558;
    wire _557;
    wire _559;
    wire [31:0] _561;
    wire _550;
    wire _549;
    wire _551;
    wire [31:0] _553;
    wire _542;
    wire _541;
    wire _543;
    wire [31:0] _545;
    wire _534;
    wire _533;
    wire _535;
    wire [31:0] _537;
    wire _526;
    wire _525;
    wire _527;
    wire [31:0] _529;
    wire _518;
    wire _517;
    wire _519;
    wire [31:0] _521;
    wire _510;
    wire _509;
    wire _511;
    wire [31:0] _513;
    wire _502;
    wire _501;
    wire _503;
    wire [31:0] _505;
    wire _494;
    wire _493;
    wire _495;
    wire [31:0] _497;
    wire _486;
    wire _485;
    wire _487;
    wire [31:0] _489;
    wire _478;
    wire _477;
    wire _479;
    wire [31:0] _481;
    wire _470;
    wire _469;
    wire _471;
    wire [31:0] _473;
    wire _462;
    wire _461;
    wire _463;
    wire [31:0] _465;
    wire _454;
    wire _453;
    wire _455;
    wire [31:0] _457;
    wire _446;
    wire _445;
    wire _447;
    wire [31:0] _449;
    wire _438;
    wire _437;
    wire _439;
    wire [31:0] _441;
    wire _430;
    wire _429;
    wire _431;
    wire [31:0] _433;
    wire _422;
    wire _421;
    wire _423;
    wire [31:0] _425;
    wire _414;
    wire _413;
    wire _415;
    wire [31:0] _417;
    wire _406;
    wire _405;
    wire _407;
    wire [31:0] _409;
    wire _398;
    wire _397;
    wire _399;
    wire [31:0] _401;
    wire _390;
    wire _389;
    wire _391;
    wire [31:0] _393;
    wire _382;
    wire _381;
    wire _383;
    wire [31:0] _385;
    wire _374;
    wire _373;
    wire _375;
    wire [31:0] _377;
    wire _366;
    wire _365;
    wire _367;
    wire [31:0] _369;
    wire _358;
    wire _357;
    wire _359;
    wire [31:0] _361;
    wire _350;
    wire _349;
    wire _351;
    wire [31:0] _353;
    wire _342;
    wire _341;
    wire _343;
    wire [31:0] _345;
    wire _334;
    wire _333;
    wire _335;
    wire [31:0] _337;
    wire _326;
    wire _325;
    wire _327;
    wire [31:0] _329;
    wire _318;
    wire _317;
    wire _319;
    wire [31:0] _321;
    wire _310;
    wire _309;
    wire _311;
    wire [31:0] _313;
    wire _302;
    wire _301;
    wire _303;
    wire [31:0] _305;
    wire _294;
    wire _293;
    wire _295;
    wire [31:0] _297;
    wire _286;
    wire _285;
    wire _287;
    wire [31:0] _289;
    wire _278;
    wire _277;
    wire _279;
    wire [31:0] _281;
    wire _270;
    wire _269;
    wire _271;
    wire [31:0] _273;
    wire _262;
    wire _261;
    wire _263;
    wire [31:0] _265;
    wire _254;
    wire _253;
    wire _255;
    wire [31:0] _257;
    wire _246;
    wire _245;
    wire _247;
    wire [31:0] _249;
    wire _238;
    wire _237;
    wire _239;
    wire [31:0] _241;
    wire _230;
    wire _229;
    wire _231;
    wire [31:0] _233;
    wire _222;
    wire _221;
    wire _223;
    wire [31:0] _225;
    wire _214;
    wire _213;
    wire _215;
    wire [31:0] _217;
    wire _206;
    wire _205;
    wire _207;
    wire [31:0] _209;
    wire _198;
    wire _197;
    wire _199;
    wire [31:0] _201;
    wire _190;
    wire _189;
    wire _191;
    wire [31:0] _193;
    wire _182;
    wire _181;
    wire _183;
    wire [31:0] _185;
    wire _174;
    wire _173;
    wire _175;
    wire [31:0] _177;
    wire _166;
    wire _165;
    wire _167;
    wire [31:0] _169;
    wire _158;
    wire _157;
    wire _159;
    wire [31:0] _161;
    wire _150;
    wire _149;
    wire _151;
    wire [31:0] _153;
    wire _142;
    wire _141;
    wire _143;
    wire [31:0] _145;
    wire _134;
    wire _133;
    wire _135;
    wire [31:0] _137;
    wire _126;
    wire _125;
    wire _127;
    wire [31:0] _129;
    wire _118;
    wire _117;
    wire _119;
    wire [31:0] _121;
    wire _110;
    wire _109;
    wire _111;
    wire [31:0] _113;
    wire _102;
    wire _101;
    wire _103;
    wire [31:0] _105;
    wire _94;
    wire _93;
    wire _95;
    wire [31:0] _97;
    wire _86;
    wire _85;
    wire _87;
    wire [31:0] _89;
    wire [31:0] _80;
    wire [63:0] _2;
    wire _77;
    wire _76;
    wire _78;
    wire [31:0] _81;
    wire [31:0] _72;
    wire [31:0] _4;
    wire [31:0] _73;
    wire [30:0] _74;
    wire _71;
    wire [31:0] _75;
    wire [31:0] _82;
    wire [30:0] _83;
    wire [31:0] _84;
    wire [31:0] _90;
    wire [30:0] _91;
    wire [31:0] _92;
    wire [31:0] _98;
    wire [30:0] _99;
    wire [31:0] _100;
    wire [31:0] _106;
    wire [30:0] _107;
    wire [31:0] _108;
    wire [31:0] _114;
    wire [30:0] _115;
    wire [31:0] _116;
    wire [31:0] _122;
    wire [30:0] _123;
    wire [31:0] _124;
    wire [31:0] _130;
    wire [30:0] _131;
    wire [31:0] _132;
    wire [31:0] _138;
    wire [30:0] _139;
    wire [31:0] _140;
    wire [31:0] _146;
    wire [30:0] _147;
    wire [31:0] _148;
    wire [31:0] _154;
    wire [30:0] _155;
    wire [31:0] _156;
    wire [31:0] _162;
    wire [30:0] _163;
    wire [31:0] _164;
    wire [31:0] _170;
    wire [30:0] _171;
    wire [31:0] _172;
    wire [31:0] _178;
    wire [30:0] _179;
    wire [31:0] _180;
    wire [31:0] _186;
    wire [30:0] _187;
    wire [31:0] _188;
    wire [31:0] _194;
    wire [30:0] _195;
    wire [31:0] _196;
    wire [31:0] _202;
    wire [30:0] _203;
    wire [31:0] _204;
    wire [31:0] _210;
    wire [30:0] _211;
    wire [31:0] _212;
    wire [31:0] _218;
    wire [30:0] _219;
    wire [31:0] _220;
    wire [31:0] _226;
    wire [30:0] _227;
    wire [31:0] _228;
    wire [31:0] _234;
    wire [30:0] _235;
    wire [31:0] _236;
    wire [31:0] _242;
    wire [30:0] _243;
    wire [31:0] _244;
    wire [31:0] _250;
    wire [30:0] _251;
    wire [31:0] _252;
    wire [31:0] _258;
    wire [30:0] _259;
    wire [31:0] _260;
    wire [31:0] _266;
    wire [30:0] _267;
    wire [31:0] _268;
    wire [31:0] _274;
    wire [30:0] _275;
    wire [31:0] _276;
    wire [31:0] _282;
    wire [30:0] _283;
    wire [31:0] _284;
    wire [31:0] _290;
    wire [30:0] _291;
    wire [31:0] _292;
    wire [31:0] _298;
    wire [30:0] _299;
    wire [31:0] _300;
    wire [31:0] _306;
    wire [30:0] _307;
    wire [31:0] _308;
    wire [31:0] _314;
    wire [30:0] _315;
    wire [31:0] _316;
    wire [31:0] _322;
    wire [30:0] _323;
    wire [31:0] _324;
    wire [31:0] _330;
    wire [30:0] _331;
    wire [31:0] _332;
    wire [31:0] _338;
    wire [30:0] _339;
    wire [31:0] _340;
    wire [31:0] _346;
    wire [30:0] _347;
    wire [31:0] _348;
    wire [31:0] _354;
    wire [30:0] _355;
    wire [31:0] _356;
    wire [31:0] _362;
    wire [30:0] _363;
    wire [31:0] _364;
    wire [31:0] _370;
    wire [30:0] _371;
    wire [31:0] _372;
    wire [31:0] _378;
    wire [30:0] _379;
    wire [31:0] _380;
    wire [31:0] _386;
    wire [30:0] _387;
    wire [31:0] _388;
    wire [31:0] _394;
    wire [30:0] _395;
    wire [31:0] _396;
    wire [31:0] _402;
    wire [30:0] _403;
    wire [31:0] _404;
    wire [31:0] _410;
    wire [30:0] _411;
    wire [31:0] _412;
    wire [31:0] _418;
    wire [30:0] _419;
    wire [31:0] _420;
    wire [31:0] _426;
    wire [30:0] _427;
    wire [31:0] _428;
    wire [31:0] _434;
    wire [30:0] _435;
    wire [31:0] _436;
    wire [31:0] _442;
    wire [30:0] _443;
    wire [31:0] _444;
    wire [31:0] _450;
    wire [30:0] _451;
    wire [31:0] _452;
    wire [31:0] _458;
    wire [30:0] _459;
    wire [31:0] _460;
    wire [31:0] _466;
    wire [30:0] _467;
    wire [31:0] _468;
    wire [31:0] _474;
    wire [30:0] _475;
    wire [31:0] _476;
    wire [31:0] _482;
    wire [30:0] _483;
    wire [31:0] _484;
    wire [31:0] _490;
    wire [30:0] _491;
    wire [31:0] _492;
    wire [31:0] _498;
    wire [30:0] _499;
    wire [31:0] _500;
    wire [31:0] _506;
    wire [30:0] _507;
    wire [31:0] _508;
    wire [31:0] _514;
    wire [30:0] _515;
    wire [31:0] _516;
    wire [31:0] _522;
    wire [30:0] _523;
    wire [31:0] _524;
    wire [31:0] _530;
    wire [30:0] _531;
    wire [31:0] _532;
    wire [31:0] _538;
    wire [30:0] _539;
    wire [31:0] _540;
    wire [31:0] _546;
    wire [30:0] _547;
    wire [31:0] _548;
    wire [31:0] _554;
    wire [30:0] _555;
    wire [31:0] _556;
    wire [31:0] _562;
    wire [30:0] _563;
    wire [31:0] _564;
    wire [31:0] _570;
    wire [30:0] _571;
    wire [31:0] _572;
    wire [31:0] _578;
    wire [30:0] _579;
    wire [31:0] _580;
    wire [31:0] _586;
    wire [3:0] _6;
    reg [31:0] _587;
    wire [31:0] _588;
    assign _584 = 32'b00000000000000000000000000000000;
    assign _582 = _2[63:63];
    assign _581 = _578[0:0];
    assign _583 = _581 ^ _582;
    assign _585 = _583 ? _80 : _584;
    assign _574 = _2[62:62];
    assign _573 = _570[0:0];
    assign _575 = _573 ^ _574;
    assign _577 = _575 ? _80 : _584;
    assign _566 = _2[61:61];
    assign _565 = _562[0:0];
    assign _567 = _565 ^ _566;
    assign _569 = _567 ? _80 : _584;
    assign _558 = _2[60:60];
    assign _557 = _554[0:0];
    assign _559 = _557 ^ _558;
    assign _561 = _559 ? _80 : _584;
    assign _550 = _2[59:59];
    assign _549 = _546[0:0];
    assign _551 = _549 ^ _550;
    assign _553 = _551 ? _80 : _584;
    assign _542 = _2[58:58];
    assign _541 = _538[0:0];
    assign _543 = _541 ^ _542;
    assign _545 = _543 ? _80 : _584;
    assign _534 = _2[57:57];
    assign _533 = _530[0:0];
    assign _535 = _533 ^ _534;
    assign _537 = _535 ? _80 : _584;
    assign _526 = _2[56:56];
    assign _525 = _522[0:0];
    assign _527 = _525 ^ _526;
    assign _529 = _527 ? _80 : _584;
    assign _518 = _2[55:55];
    assign _517 = _514[0:0];
    assign _519 = _517 ^ _518;
    assign _521 = _519 ? _80 : _584;
    assign _510 = _2[54:54];
    assign _509 = _506[0:0];
    assign _511 = _509 ^ _510;
    assign _513 = _511 ? _80 : _584;
    assign _502 = _2[53:53];
    assign _501 = _498[0:0];
    assign _503 = _501 ^ _502;
    assign _505 = _503 ? _80 : _584;
    assign _494 = _2[52:52];
    assign _493 = _490[0:0];
    assign _495 = _493 ^ _494;
    assign _497 = _495 ? _80 : _584;
    assign _486 = _2[51:51];
    assign _485 = _482[0:0];
    assign _487 = _485 ^ _486;
    assign _489 = _487 ? _80 : _584;
    assign _478 = _2[50:50];
    assign _477 = _474[0:0];
    assign _479 = _477 ^ _478;
    assign _481 = _479 ? _80 : _584;
    assign _470 = _2[49:49];
    assign _469 = _466[0:0];
    assign _471 = _469 ^ _470;
    assign _473 = _471 ? _80 : _584;
    assign _462 = _2[48:48];
    assign _461 = _458[0:0];
    assign _463 = _461 ^ _462;
    assign _465 = _463 ? _80 : _584;
    assign _454 = _2[47:47];
    assign _453 = _450[0:0];
    assign _455 = _453 ^ _454;
    assign _457 = _455 ? _80 : _584;
    assign _446 = _2[46:46];
    assign _445 = _442[0:0];
    assign _447 = _445 ^ _446;
    assign _449 = _447 ? _80 : _584;
    assign _438 = _2[45:45];
    assign _437 = _434[0:0];
    assign _439 = _437 ^ _438;
    assign _441 = _439 ? _80 : _584;
    assign _430 = _2[44:44];
    assign _429 = _426[0:0];
    assign _431 = _429 ^ _430;
    assign _433 = _431 ? _80 : _584;
    assign _422 = _2[43:43];
    assign _421 = _418[0:0];
    assign _423 = _421 ^ _422;
    assign _425 = _423 ? _80 : _584;
    assign _414 = _2[42:42];
    assign _413 = _410[0:0];
    assign _415 = _413 ^ _414;
    assign _417 = _415 ? _80 : _584;
    assign _406 = _2[41:41];
    assign _405 = _402[0:0];
    assign _407 = _405 ^ _406;
    assign _409 = _407 ? _80 : _584;
    assign _398 = _2[40:40];
    assign _397 = _394[0:0];
    assign _399 = _397 ^ _398;
    assign _401 = _399 ? _80 : _584;
    assign _390 = _2[39:39];
    assign _389 = _386[0:0];
    assign _391 = _389 ^ _390;
    assign _393 = _391 ? _80 : _584;
    assign _382 = _2[38:38];
    assign _381 = _378[0:0];
    assign _383 = _381 ^ _382;
    assign _385 = _383 ? _80 : _584;
    assign _374 = _2[37:37];
    assign _373 = _370[0:0];
    assign _375 = _373 ^ _374;
    assign _377 = _375 ? _80 : _584;
    assign _366 = _2[36:36];
    assign _365 = _362[0:0];
    assign _367 = _365 ^ _366;
    assign _369 = _367 ? _80 : _584;
    assign _358 = _2[35:35];
    assign _357 = _354[0:0];
    assign _359 = _357 ^ _358;
    assign _361 = _359 ? _80 : _584;
    assign _350 = _2[34:34];
    assign _349 = _346[0:0];
    assign _351 = _349 ^ _350;
    assign _353 = _351 ? _80 : _584;
    assign _342 = _2[33:33];
    assign _341 = _338[0:0];
    assign _343 = _341 ^ _342;
    assign _345 = _343 ? _80 : _584;
    assign _334 = _2[32:32];
    assign _333 = _330[0:0];
    assign _335 = _333 ^ _334;
    assign _337 = _335 ? _80 : _584;
    assign _326 = _2[31:31];
    assign _325 = _322[0:0];
    assign _327 = _325 ^ _326;
    assign _329 = _327 ? _80 : _584;
    assign _318 = _2[30:30];
    assign _317 = _314[0:0];
    assign _319 = _317 ^ _318;
    assign _321 = _319 ? _80 : _584;
    assign _310 = _2[29:29];
    assign _309 = _306[0:0];
    assign _311 = _309 ^ _310;
    assign _313 = _311 ? _80 : _584;
    assign _302 = _2[28:28];
    assign _301 = _298[0:0];
    assign _303 = _301 ^ _302;
    assign _305 = _303 ? _80 : _584;
    assign _294 = _2[27:27];
    assign _293 = _290[0:0];
    assign _295 = _293 ^ _294;
    assign _297 = _295 ? _80 : _584;
    assign _286 = _2[26:26];
    assign _285 = _282[0:0];
    assign _287 = _285 ^ _286;
    assign _289 = _287 ? _80 : _584;
    assign _278 = _2[25:25];
    assign _277 = _274[0:0];
    assign _279 = _277 ^ _278;
    assign _281 = _279 ? _80 : _584;
    assign _270 = _2[24:24];
    assign _269 = _266[0:0];
    assign _271 = _269 ^ _270;
    assign _273 = _271 ? _80 : _584;
    assign _262 = _2[23:23];
    assign _261 = _258[0:0];
    assign _263 = _261 ^ _262;
    assign _265 = _263 ? _80 : _584;
    assign _254 = _2[22:22];
    assign _253 = _250[0:0];
    assign _255 = _253 ^ _254;
    assign _257 = _255 ? _80 : _584;
    assign _246 = _2[21:21];
    assign _245 = _242[0:0];
    assign _247 = _245 ^ _246;
    assign _249 = _247 ? _80 : _584;
    assign _238 = _2[20:20];
    assign _237 = _234[0:0];
    assign _239 = _237 ^ _238;
    assign _241 = _239 ? _80 : _584;
    assign _230 = _2[19:19];
    assign _229 = _226[0:0];
    assign _231 = _229 ^ _230;
    assign _233 = _231 ? _80 : _584;
    assign _222 = _2[18:18];
    assign _221 = _218[0:0];
    assign _223 = _221 ^ _222;
    assign _225 = _223 ? _80 : _584;
    assign _214 = _2[17:17];
    assign _213 = _210[0:0];
    assign _215 = _213 ^ _214;
    assign _217 = _215 ? _80 : _584;
    assign _206 = _2[16:16];
    assign _205 = _202[0:0];
    assign _207 = _205 ^ _206;
    assign _209 = _207 ? _80 : _584;
    assign _198 = _2[15:15];
    assign _197 = _194[0:0];
    assign _199 = _197 ^ _198;
    assign _201 = _199 ? _80 : _584;
    assign _190 = _2[14:14];
    assign _189 = _186[0:0];
    assign _191 = _189 ^ _190;
    assign _193 = _191 ? _80 : _584;
    assign _182 = _2[13:13];
    assign _181 = _178[0:0];
    assign _183 = _181 ^ _182;
    assign _185 = _183 ? _80 : _584;
    assign _174 = _2[12:12];
    assign _173 = _170[0:0];
    assign _175 = _173 ^ _174;
    assign _177 = _175 ? _80 : _584;
    assign _166 = _2[11:11];
    assign _165 = _162[0:0];
    assign _167 = _165 ^ _166;
    assign _169 = _167 ? _80 : _584;
    assign _158 = _2[10:10];
    assign _157 = _154[0:0];
    assign _159 = _157 ^ _158;
    assign _161 = _159 ? _80 : _584;
    assign _150 = _2[9:9];
    assign _149 = _146[0:0];
    assign _151 = _149 ^ _150;
    assign _153 = _151 ? _80 : _584;
    assign _142 = _2[8:8];
    assign _141 = _138[0:0];
    assign _143 = _141 ^ _142;
    assign _145 = _143 ? _80 : _584;
    assign _134 = _2[7:7];
    assign _133 = _130[0:0];
    assign _135 = _133 ^ _134;
    assign _137 = _135 ? _80 : _584;
    assign _126 = _2[6:6];
    assign _125 = _122[0:0];
    assign _127 = _125 ^ _126;
    assign _129 = _127 ? _80 : _584;
    assign _118 = _2[5:5];
    assign _117 = _114[0:0];
    assign _119 = _117 ^ _118;
    assign _121 = _119 ? _80 : _584;
    assign _110 = _2[4:4];
    assign _109 = _106[0:0];
    assign _111 = _109 ^ _110;
    assign _113 = _111 ? _80 : _584;
    assign _102 = _2[3:3];
    assign _101 = _98[0:0];
    assign _103 = _101 ^ _102;
    assign _105 = _103 ? _80 : _584;
    assign _94 = _2[2:2];
    assign _93 = _90[0:0];
    assign _95 = _93 ^ _94;
    assign _97 = _95 ? _80 : _584;
    assign _86 = _2[1:1];
    assign _85 = _82[0:0];
    assign _87 = _85 ^ _86;
    assign _89 = _87 ? _80 : _584;
    assign _80 = 32'b11101101101110001000001100100000;
    assign _2 = data;
    assign _77 = _2[0:0];
    assign _76 = _73[0:0];
    assign _78 = _76 ^ _77;
    assign _81 = _78 ? _80 : _584;
    assign _72 = 32'b11111111111111111111111111111111;
    assign _4 = crc_in;
    assign _73 = _4 ^ _72;
    assign _74 = _73[31:1];
    assign _71 = 1'b0;
    assign _75 = { _71,
                   _74 };
    assign _82 = _75 ^ _81;
    assign _83 = _82[31:1];
    assign _84 = { _71,
                   _83 };
    assign _90 = _84 ^ _89;
    assign _91 = _90[31:1];
    assign _92 = { _71,
                   _91 };
    assign _98 = _92 ^ _97;
    assign _99 = _98[31:1];
    assign _100 = { _71,
                    _99 };
    assign _106 = _100 ^ _105;
    assign _107 = _106[31:1];
    assign _108 = { _71,
                    _107 };
    assign _114 = _108 ^ _113;
    assign _115 = _114[31:1];
    assign _116 = { _71,
                    _115 };
    assign _122 = _116 ^ _121;
    assign _123 = _122[31:1];
    assign _124 = { _71,
                    _123 };
    assign _130 = _124 ^ _129;
    assign _131 = _130[31:1];
    assign _132 = { _71,
                    _131 };
    assign _138 = _132 ^ _137;
    assign _139 = _138[31:1];
    assign _140 = { _71,
                    _139 };
    assign _146 = _140 ^ _145;
    assign _147 = _146[31:1];
    assign _148 = { _71,
                    _147 };
    assign _154 = _148 ^ _153;
    assign _155 = _154[31:1];
    assign _156 = { _71,
                    _155 };
    assign _162 = _156 ^ _161;
    assign _163 = _162[31:1];
    assign _164 = { _71,
                    _163 };
    assign _170 = _164 ^ _169;
    assign _171 = _170[31:1];
    assign _172 = { _71,
                    _171 };
    assign _178 = _172 ^ _177;
    assign _179 = _178[31:1];
    assign _180 = { _71,
                    _179 };
    assign _186 = _180 ^ _185;
    assign _187 = _186[31:1];
    assign _188 = { _71,
                    _187 };
    assign _194 = _188 ^ _193;
    assign _195 = _194[31:1];
    assign _196 = { _71,
                    _195 };
    assign _202 = _196 ^ _201;
    assign _203 = _202[31:1];
    assign _204 = { _71,
                    _203 };
    assign _210 = _204 ^ _209;
    assign _211 = _210[31:1];
    assign _212 = { _71,
                    _211 };
    assign _218 = _212 ^ _217;
    assign _219 = _218[31:1];
    assign _220 = { _71,
                    _219 };
    assign _226 = _220 ^ _225;
    assign _227 = _226[31:1];
    assign _228 = { _71,
                    _227 };
    assign _234 = _228 ^ _233;
    assign _235 = _234[31:1];
    assign _236 = { _71,
                    _235 };
    assign _242 = _236 ^ _241;
    assign _243 = _242[31:1];
    assign _244 = { _71,
                    _243 };
    assign _250 = _244 ^ _249;
    assign _251 = _250[31:1];
    assign _252 = { _71,
                    _251 };
    assign _258 = _252 ^ _257;
    assign _259 = _258[31:1];
    assign _260 = { _71,
                    _259 };
    assign _266 = _260 ^ _265;
    assign _267 = _266[31:1];
    assign _268 = { _71,
                    _267 };
    assign _274 = _268 ^ _273;
    assign _275 = _274[31:1];
    assign _276 = { _71,
                    _275 };
    assign _282 = _276 ^ _281;
    assign _283 = _282[31:1];
    assign _284 = { _71,
                    _283 };
    assign _290 = _284 ^ _289;
    assign _291 = _290[31:1];
    assign _292 = { _71,
                    _291 };
    assign _298 = _292 ^ _297;
    assign _299 = _298[31:1];
    assign _300 = { _71,
                    _299 };
    assign _306 = _300 ^ _305;
    assign _307 = _306[31:1];
    assign _308 = { _71,
                    _307 };
    assign _314 = _308 ^ _313;
    assign _315 = _314[31:1];
    assign _316 = { _71,
                    _315 };
    assign _322 = _316 ^ _321;
    assign _323 = _322[31:1];
    assign _324 = { _71,
                    _323 };
    assign _330 = _324 ^ _329;
    assign _331 = _330[31:1];
    assign _332 = { _71,
                    _331 };
    assign _338 = _332 ^ _337;
    assign _339 = _338[31:1];
    assign _340 = { _71,
                    _339 };
    assign _346 = _340 ^ _345;
    assign _347 = _346[31:1];
    assign _348 = { _71,
                    _347 };
    assign _354 = _348 ^ _353;
    assign _355 = _354[31:1];
    assign _356 = { _71,
                    _355 };
    assign _362 = _356 ^ _361;
    assign _363 = _362[31:1];
    assign _364 = { _71,
                    _363 };
    assign _370 = _364 ^ _369;
    assign _371 = _370[31:1];
    assign _372 = { _71,
                    _371 };
    assign _378 = _372 ^ _377;
    assign _379 = _378[31:1];
    assign _380 = { _71,
                    _379 };
    assign _386 = _380 ^ _385;
    assign _387 = _386[31:1];
    assign _388 = { _71,
                    _387 };
    assign _394 = _388 ^ _393;
    assign _395 = _394[31:1];
    assign _396 = { _71,
                    _395 };
    assign _402 = _396 ^ _401;
    assign _403 = _402[31:1];
    assign _404 = { _71,
                    _403 };
    assign _410 = _404 ^ _409;
    assign _411 = _410[31:1];
    assign _412 = { _71,
                    _411 };
    assign _418 = _412 ^ _417;
    assign _419 = _418[31:1];
    assign _420 = { _71,
                    _419 };
    assign _426 = _420 ^ _425;
    assign _427 = _426[31:1];
    assign _428 = { _71,
                    _427 };
    assign _434 = _428 ^ _433;
    assign _435 = _434[31:1];
    assign _436 = { _71,
                    _435 };
    assign _442 = _436 ^ _441;
    assign _443 = _442[31:1];
    assign _444 = { _71,
                    _443 };
    assign _450 = _444 ^ _449;
    assign _451 = _450[31:1];
    assign _452 = { _71,
                    _451 };
    assign _458 = _452 ^ _457;
    assign _459 = _458[31:1];
    assign _460 = { _71,
                    _459 };
    assign _466 = _460 ^ _465;
    assign _467 = _466[31:1];
    assign _468 = { _71,
                    _467 };
    assign _474 = _468 ^ _473;
    assign _475 = _474[31:1];
    assign _476 = { _71,
                    _475 };
    assign _482 = _476 ^ _481;
    assign _483 = _482[31:1];
    assign _484 = { _71,
                    _483 };
    assign _490 = _484 ^ _489;
    assign _491 = _490[31:1];
    assign _492 = { _71,
                    _491 };
    assign _498 = _492 ^ _497;
    assign _499 = _498[31:1];
    assign _500 = { _71,
                    _499 };
    assign _506 = _500 ^ _505;
    assign _507 = _506[31:1];
    assign _508 = { _71,
                    _507 };
    assign _514 = _508 ^ _513;
    assign _515 = _514[31:1];
    assign _516 = { _71,
                    _515 };
    assign _522 = _516 ^ _521;
    assign _523 = _522[31:1];
    assign _524 = { _71,
                    _523 };
    assign _530 = _524 ^ _529;
    assign _531 = _530[31:1];
    assign _532 = { _71,
                    _531 };
    assign _538 = _532 ^ _537;
    assign _539 = _538[31:1];
    assign _540 = { _71,
                    _539 };
    assign _546 = _540 ^ _545;
    assign _547 = _546[31:1];
    assign _548 = { _71,
                    _547 };
    assign _554 = _548 ^ _553;
    assign _555 = _554[31:1];
    assign _556 = { _71,
                    _555 };
    assign _562 = _556 ^ _561;
    assign _563 = _562[31:1];
    assign _564 = { _71,
                    _563 };
    assign _570 = _564 ^ _569;
    assign _571 = _570[31:1];
    assign _572 = { _71,
                    _571 };
    assign _578 = _572 ^ _577;
    assign _579 = _578[31:1];
    assign _580 = { _71,
                    _579 };
    assign _586 = _580 ^ _585;
    assign _6 = octet_count;
    always @* begin
        case (_6)
        0:
            _587 <= _586;
        1:
            _587 <= _138;
        2:
            _587 <= _202;
        3:
            _587 <= _266;
        4:
            _587 <= _330;
        5:
            _587 <= _394;
        6:
            _587 <= _458;
        7:
            _587 <= _522;
        8:
            _587 <= _586;
        9:
            _587 <= _586;
        10:
            _587 <= _586;
        11:
            _587 <= _586;
        12:
            _587 <= _586;
        13:
            _587 <= _586;
        14:
            _587 <= _586;
        default:
            _587 <= _586;
        endcase
    end
    assign _588 = _587 ^ _72;
    assign crc_out = _588;

endmodule
module xgmii_rx_64 (
    clock,
    clear,
    cfg_rx_enable,
    xgmii_rxd,
    xgmii_rxc,
    rx_tvalid,
    rx_tdata,
    rx_tkeep,
    rx_tstrb,
    rx_tlast,
    rx_tuser,
    error_bad_fcs,
    error_bad_frame,
    error_runt,
    error_oversize,
    error_start_without_terminate
);

    input clock;
    input clear;
    input cfg_rx_enable;
    input [63:0] xgmii_rxd;
    input [7:0] xgmii_rxc;
    output rx_tvalid;
    output [63:0] rx_tdata;
    output [7:0] rx_tkeep;
    output [7:0] rx_tstrb;
    output rx_tlast;
    output rx_tuser;
    output error_bad_fcs;
    output error_bad_frame;
    output error_runt;
    output error_oversize;
    output error_start_without_terminate;

    wire _503;
    wire _502;
    wire _504;
    wire _375;
    wire _374;
    wire _376;
    wire _505;
    wire _508;
    wire _507;
    wire _509;
    wire _515;
    wire _514;
    wire _516;
    wire _512;
    wire _511;
    wire _513;
    wire _517;
    wire _523;
    wire [2:0] _500;
    wire [7:0] _490;
    wire [7:0] _488;
    wire [7:0] _489;
    wire _491;
    wire _492;
    wire _493;
    wire [7:0] _483;
    wire _485;
    wire _486;
    wire _487;
    wire _475;
    wire _476;
    wire _473;
    wire _474;
    wire _471;
    wire _472;
    wire _469;
    wire _470;
    wire _467;
    wire _468;
    wire _465;
    wire _466;
    wire _461;
    wire _459;
    wire _457;
    wire _455;
    wire _453;
    wire _451;
    wire _450;
    wire _452;
    wire _454;
    wire _456;
    wire _458;
    wire _460;
    wire _462;
    wire _463;
    wire _449;
    wire _464;
    wire [7:0] _477;
    wire [7:0] _478;
    wire _480;
    wire _481;
    wire _446;
    wire _447;
    wire _448;
    wire _482;
    wire [2:0] _494;
    wire [7:0] _429;
    wire [7:0] _430;
    wire _432;
    wire _433;
    wire _434;
    wire [7:0] _424;
    wire _426;
    wire _427;
    wire _428;
    wire _416;
    wire _417;
    wire _414;
    wire _415;
    wire _412;
    wire _413;
    wire _410;
    wire _411;
    wire _408;
    wire _409;
    wire _406;
    wire _407;
    wire _402;
    wire _400;
    wire _398;
    wire _396;
    wire _394;
    wire _392;
    wire _391;
    wire _393;
    wire _395;
    wire _397;
    wire _399;
    wire _401;
    wire _403;
    wire _404;
    wire _390;
    wire _405;
    wire [7:0] _418;
    wire [7:0] _419;
    wire _421;
    wire _422;
    wire _387;
    wire _388;
    wire _389;
    wire _423;
    wire [2:0] _435;
    wire [2:0] _495;
    reg [2:0] _498;
    reg [2:0] _501;
    wire _522;
    wire _524;
    wire _520;
    wire _519;
    wire _521;
    wire _525;
    wire _528;
    wire _527;
    wire _529;
    wire _510;
    wire _373;
    wire _518;
    wire _526;
    wire _725;
    wire _726;
    wire _727;
    wire _728;
    wire _729;
    wire _730;
    wire _731;
    wire [7:0] _744;
    wire [3:0] _736;
    wire [3:0] _733;
    wire [3:0] _734;
    wire [3:0] _735;
    wire [3:0] _737;
    reg [7:0] _745;
    wire [63:0] _753;
    wire [127:0] _749;
    wire [63:0] _750;
    reg [63:0] _748;
    wire [63:0] _751;
    reg [63:0] _754;
    wire _845;
    wire _842;
    wire _616;
    wire [3:0] _713;
    wire [3:0] _712;
    wire _506;
    wire _709;
    wire _710;
    wire [6:0] _371;
    wire [6:0] _802;
    wire [2:0] _797;
    wire _794;
    wire [1:0] _795;
    wire [3:0] _796;
    wire [6:0] _798;
    wire [6:0] _799;
    wire [2:0] _787;
    wire _34;
    wire _33;
    wire _35;
    wire _782;
    wire _781;
    wire _783;
    wire _715;
    wire _706;
    wire _707;
    wire _716;
    wire _724;
    wire _755;
    wire _756;
    wire _11;
    wire _784;
    wire [1:0] _785;
    wire [3:0] _786;
    wire [6:0] _788;
    wire [6:0] _789;
    wire _368;
    wire _367;
    wire _369;
    wire [31:0] _348;
    wire [31:0] _760;
    wire [31:0] _759;
    wire [63:0] _761;
    wire _758;
    wire [63:0] _762;
    wire [31:0] _764;
    wire [31:0] _12;
    wire [31:0] _777;
    reg [31:0] _780;
    wire [31:0] _13;
    wire _345;
    wire _346;
    wire [31:0] _347;
    wire _349;
    wire _350;
    wire [10:0] _341;
    wire _342;
    wire _343;
    wire _351;
    wire _352;
    wire [10:0] _338;
    wire _339;
    wire _340;
    wire [6:0] _370;
    wire [6:0] _790;
    reg [6:0] _793;
    wire [6:0] _14;
    wire [6:0] _800;
    reg [6:0] _803;
    wire [6:0] _15;
    wire _32;
    wire [6:0] _372;
    wire _708;
    wire _711;
    wire [3:0] _714;
    wire _721;
    wire _722;
    wire _698;
    wire [3:0] _699;
    wire _695;
    wire [3:0] _696;
    wire [3:0] _700;
    wire _691;
    wire [3:0] _692;
    wire _688;
    wire [3:0] _689;
    wire [3:0] _693;
    wire [3:0] _701;
    wire _683;
    wire [3:0] _684;
    wire _680;
    wire [3:0] _681;
    wire [3:0] _685;
    wire _676;
    wire [3:0] _677;
    wire _673;
    wire [3:0] _674;
    wire [3:0] _678;
    wire [3:0] _686;
    wire [3:0] _702;
    wire [15:0] _666;
    wire [7:0] _667;
    wire _658;
    wire [1:0] _659;
    wire [3:0] _660;
    wire [7:0] _661;
    wire _655;
    wire _654;
    wire _653;
    wire _652;
    wire _651;
    wire _650;
    wire _649;
    wire _647;
    wire _648;
    wire _645;
    wire _646;
    wire _643;
    wire _644;
    wire _641;
    wire _642;
    wire _638;
    wire _639;
    wire _640;
    wire _635;
    wire _636;
    wire _637;
    wire _631;
    wire _632;
    wire _633;
    wire _634;
    wire _627;
    wire _628;
    wire _629;
    wire _630;
    wire _623;
    wire _622;
    wire _624;
    wire _621;
    wire _625;
    wire _620;
    wire _626;
    wire [15:0] _656;
    wire [7:0] _657;
    wire [7:0] _662;
    reg [7:0] _665;
    wire [7:0] _668;
    wire _670;
    wire _671;
    wire [3:0] _704;
    wire _718;
    wire _719;
    wire _720;
    wire _723;
    wire _16;
    reg _617;
    wire _618;
    wire _607;
    wire [3:0] _608;
    wire _604;
    wire [3:0] _605;
    wire [3:0] _609;
    wire _600;
    wire [3:0] _601;
    wire _597;
    wire [3:0] _598;
    wire [3:0] _602;
    wire [3:0] _610;
    wire _592;
    wire [3:0] _593;
    wire _589;
    wire [3:0] _590;
    wire [3:0] _594;
    wire _585;
    wire [3:0] _586;
    wire [15:0] _576;
    wire [7:0] _577;
    wire [1:0] _569;
    wire [3:0] _570;
    wire [7:0] _571;
    wire [7:0] _558;
    wire [7:0] _557;
    wire [7:0] _556;
    wire [7:0] _555;
    wire [7:0] _554;
    wire [7:0] _553;
    wire [7:0] _552;
    reg [7:0] _567;
    wire [7:0] _541;
    wire [7:0] _540;
    wire [7:0] _539;
    wire [7:0] _538;
    wire [7:0] _537;
    wire [7:0] _536;
    wire [7:0] _535;
    wire _252;
    wire _253;
    wire _254;
    wire _255;
    wire _248;
    wire _247;
    wire _249;
    wire _250;
    wire _251;
    wire _245;
    wire _243;
    wire _241;
    wire _240;
    wire _242;
    wire _244;
    wire _246;
    wire [2:0] _256;
    wire [3:0] _257;
    wire [3:0] _210;
    wire [1:0] _38;
    wire [1:0] _832;
    wire [1:0] _828;
    wire [1:0] _829;
    wire [1:0] _830;
    wire [7:0] _353;
    wire _355;
    wire _356;
    wire _357;
    wire [7:0] _358;
    wire [7:0] _359;
    wire [7:0] _360;
    wire _362;
    wire _363;
    wire _364;
    wire _237;
    wire _238;
    wire _235;
    wire _236;
    wire _233;
    wire _234;
    wire _231;
    wire _232;
    wire _229;
    wire _230;
    wire _227;
    wire _228;
    wire _223;
    wire _221;
    wire _219;
    wire _217;
    wire _215;
    wire _213;
    wire _212;
    wire _214;
    wire _216;
    wire _218;
    wire _220;
    wire _222;
    wire _224;
    wire _225;
    wire _211;
    wire _226;
    wire [7:0] _239;
    wire [7:0] _322;
    wire _324;
    wire _325;
    wire _320;
    wire _321;
    wire _326;
    wire _365;
    wire _366;
    wire [1:0] _824;
    wire _318;
    wire _308;
    wire _309;
    wire _310;
    wire _311;
    wire _304;
    wire _303;
    wire _305;
    wire _306;
    wire _307;
    wire _301;
    wire _299;
    wire _297;
    wire _293;
    wire _294;
    wire _291;
    wire _292;
    wire _289;
    wire _290;
    wire _287;
    wire _288;
    wire _285;
    wire _286;
    wire _283;
    wire _284;
    wire _279;
    wire _277;
    wire _275;
    wire _273;
    wire _271;
    wire _269;
    wire _268;
    wire _270;
    wire _272;
    wire _274;
    wire _276;
    wire _278;
    wire _280;
    wire _281;
    wire _267;
    wire _282;
    wire [7:0] _295;
    wire _296;
    wire _298;
    wire _300;
    wire _302;
    wire [2:0] _312;
    wire [3:0] _313;
    wire [7:0] _261;
    wire [7:0] _262;
    wire _264;
    wire _265;
    wire [3:0] _314;
    wire _315;
    wire [3:0] _67;
    wire [4:0] _64;
    wire [3:0] _59;
    wire [10:0] _56;
    wire [10:0] _807;
    wire [3:0] _334;
    wire _332;
    wire [3:0] _335;
    wire [10:0] _336;
    wire [10:0] _337;
    wire [10:0] _805;
    reg [10:0] _808;
    wire [10:0] _17;
    wire [10:0] _54;
    wire [10:0] _55;
    wire _57;
    wire _58;
    wire [3:0] _61;
    wire [4:0] _62;
    reg _811;
    wire _18;
    wire [3:0] _51;
    wire [3:0] _48;
    wire [3:0] _52;
    wire [4:0] _53;
    wire [4:0] _63;
    wire _65;
    wire _66;
    wire [3:0] _69;
    wire _259;
    wire _43;
    wire _44;
    wire _260;
    wire _316;
    wire _319;
    wire [1:0] _825;
    wire [1:0] _826;
    wire _819;
    wire _820;
    wire [1:0] _821;
    wire [1:0] _822;
    wire [1:0] _816;
    wire _817;
    wire [1:0] _823;
    wire [1:0] _42;
    wire _815;
    wire [1:0] _827;
    wire _814;
    wire [1:0] _831;
    wire _813;
    wire [1:0] _833;
    wire [1:0] _19;
    reg [1:0] _40;
    wire [1:0] _36;
    wire _41;
    wire _199;
    wire [1:0] _200;
    wire [3:0] _201;
    wire [7:0] _202;
    wire [7:0] _204;
    wire [7:0] _205;
    wire [7:0] _152;
    wire [7:0] _194;
    wire [7:0] _206;
    wire _208;
    wire _209;
    wire [3:0] _258;
    wire _328;
    wire [3:0] _329;
    wire _330;
    wire [3:0] _331;
    reg [7:0] _550;
    wire [7:0] _568;
    wire [7:0] _572;
    reg [7:0] _575;
    wire gnd;
    wire vdd;
    wire _21;
    wire _836;
    reg _839;
    wire _840;
    wire _834;
    wire [7:0] _440;
    wire [7:0] _441;
    wire [7:0] _442;
    wire [7:0] _444;
    wire _771;
    wire _772;
    wire _773;
    wire _438;
    wire _436;
    wire _437;
    wire _439;
    wire _774;
    wire [7:0] _195;
    wire [7:0] _196;
    wire [7:0] _197;
    wire [7:0] _198;
    wire [7:0] _147;
    wire _149;
    wire _146;
    wire _150;
    wire [7:0] _142;
    wire _144;
    wire _141;
    wire _145;
    wire [7:0] _137;
    wire _139;
    wire _136;
    wire _140;
    wire [7:0] _132;
    wire _134;
    wire _131;
    wire _135;
    wire [7:0] _127;
    wire _129;
    wire _126;
    wire _130;
    wire [7:0] _122;
    wire _124;
    wire _121;
    wire _125;
    wire [7:0] _117;
    wire _119;
    wire _116;
    wire _120;
    wire [7:0] _112;
    wire _114;
    wire _111;
    wire _115;
    wire [7:0] _151;
    wire [7:0] _107;
    wire [7:0] _106;
    wire _108;
    wire _105;
    wire _109;
    wire [7:0] _101;
    wire _103;
    wire _100;
    wire _104;
    wire [7:0] _96;
    wire _98;
    wire _95;
    wire _99;
    wire [7:0] _91;
    wire _93;
    wire _90;
    wire _94;
    wire [7:0] _86;
    wire _88;
    wire _85;
    wire _89;
    wire [7:0] _81;
    wire _83;
    wire _80;
    wire _84;
    wire [7:0] _76;
    wire _78;
    wire _75;
    wire _79;
    wire [7:0] _71;
    wire _73;
    wire _70;
    wire _74;
    wire [7:0] _110;
    wire [7:0] _381;
    wire [7:0] _382;
    wire [7:0] _383;
    wire [7:0] _385;
    wire _766;
    wire _767;
    wire _768;
    wire _23;
    wire _379;
    wire _25;
    wire [7:0] _190;
    wire [7:0] _189;
    wire _191;
    wire _188;
    wire _192;
    wire [7:0] _184;
    wire _186;
    wire _183;
    wire _187;
    wire [7:0] _179;
    wire _181;
    wire _178;
    wire _182;
    wire [7:0] _174;
    wire _176;
    wire _173;
    wire _177;
    wire [7:0] _169;
    wire _171;
    wire _168;
    wire _172;
    wire [7:0] _164;
    wire _166;
    wire _163;
    wire _167;
    wire [7:0] _159;
    wire _161;
    wire _158;
    wire _162;
    wire [63:0] _27;
    wire [7:0] _154;
    wire _156;
    wire [7:0] _29;
    wire _153;
    wire _157;
    wire [7:0] _193;
    wire _377;
    wire _378;
    wire _380;
    wire _769;
    wire _775;
    wire _835;
    wire _841;
    wire _30;
    reg _533;
    wire [7:0] _578;
    reg [7:0] _581;
    wire _582;
    wire [3:0] _583;
    wire [3:0] _587;
    wire [3:0] _595;
    wire [3:0] _611;
    wire _613;
    wire _614;
    wire _619;
    wire _843;
    wire _844;
    wire _846;
    assign _503 = ~ _23;
    assign _502 = _501[2:2];
    assign _504 = _502 & _503;
    assign _375 = ~ _23;
    assign _374 = _11 & _373;
    assign _376 = _374 & _375;
    assign _505 = _376 | _504;
    assign _508 = ~ _23;
    assign _507 = _11 & _506;
    assign _509 = _507 & _508;
    assign _515 = ~ _23;
    assign _514 = _501[1:1];
    assign _516 = _514 & _515;
    assign _512 = ~ _23;
    assign _511 = _11 & _510;
    assign _513 = _511 & _512;
    assign _517 = _513 | _516;
    assign _523 = ~ _23;
    assign _500 = 3'b000;
    assign _490 = 8'b00000000;
    assign _488 = _151 | _198;
    assign _489 = _488 & _477;
    assign _491 = _489 == _490;
    assign _492 = ~ _491;
    assign _493 = _448 & _492;
    assign _483 = _110 & _477;
    assign _485 = _483 == _490;
    assign _486 = ~ _485;
    assign _487 = _448 & _486;
    assign _475 = ~ _450;
    assign _476 = _451 & _475;
    assign _473 = ~ _452;
    assign _474 = _453 & _473;
    assign _471 = ~ _454;
    assign _472 = _455 & _471;
    assign _469 = ~ _456;
    assign _470 = _457 & _469;
    assign _467 = ~ _458;
    assign _468 = _459 & _467;
    assign _465 = ~ _460;
    assign _466 = _461 & _465;
    assign _461 = _444[6:6];
    assign _459 = _444[5:5];
    assign _457 = _444[4:4];
    assign _455 = _444[3:3];
    assign _453 = _444[2:2];
    assign _451 = _444[1:1];
    assign _450 = _444[0:0];
    assign _452 = _450 | _451;
    assign _454 = _452 | _453;
    assign _456 = _454 | _455;
    assign _458 = _456 | _457;
    assign _460 = _458 | _459;
    assign _462 = _460 | _461;
    assign _463 = ~ _462;
    assign _449 = _444[7:7];
    assign _464 = _449 & _463;
    assign _477 = { _464,
                    _466,
                    _468,
                    _470,
                    _472,
                    _474,
                    _476,
                    _450 };
    assign _478 = _193 & _477;
    assign _480 = _478 == _490;
    assign _481 = ~ _480;
    assign _446 = _444 == _490;
    assign _447 = ~ _446;
    assign _448 = _439 & _447;
    assign _482 = _448 & _481;
    assign _494 = { _482,
                    _487,
                    _493 };
    assign _429 = _151 | _198;
    assign _430 = _429 & _418;
    assign _432 = _430 == _490;
    assign _433 = ~ _432;
    assign _434 = _389 & _433;
    assign _424 = _110 & _418;
    assign _426 = _424 == _490;
    assign _427 = ~ _426;
    assign _428 = _389 & _427;
    assign _416 = ~ _391;
    assign _417 = _392 & _416;
    assign _414 = ~ _393;
    assign _415 = _394 & _414;
    assign _412 = ~ _395;
    assign _413 = _396 & _412;
    assign _410 = ~ _397;
    assign _411 = _398 & _410;
    assign _408 = ~ _399;
    assign _409 = _400 & _408;
    assign _406 = ~ _401;
    assign _407 = _402 & _406;
    assign _402 = _385[6:6];
    assign _400 = _385[5:5];
    assign _398 = _385[4:4];
    assign _396 = _385[3:3];
    assign _394 = _385[2:2];
    assign _392 = _385[1:1];
    assign _391 = _385[0:0];
    assign _393 = _391 | _392;
    assign _395 = _393 | _394;
    assign _397 = _395 | _396;
    assign _399 = _397 | _398;
    assign _401 = _399 | _400;
    assign _403 = _401 | _402;
    assign _404 = ~ _403;
    assign _390 = _385[7:7];
    assign _405 = _390 & _404;
    assign _418 = { _405,
                    _407,
                    _409,
                    _411,
                    _413,
                    _415,
                    _417,
                    _391 };
    assign _419 = _193 & _418;
    assign _421 = _419 == _490;
    assign _422 = ~ _421;
    assign _387 = _385 == _490;
    assign _388 = ~ _387;
    assign _389 = _380 & _388;
    assign _423 = _389 & _422;
    assign _435 = { _423,
                    _428,
                    _434 };
    assign _495 = _435 | _494;
    always @(posedge _21) begin
        if (_23)
            _498 <= _500;
        else
            _498 <= _495;
    end
    always @(posedge _21) begin
        if (_23)
            _501 <= _500;
        else
            _501 <= _498;
    end
    assign _522 = _501[0:0];
    assign _524 = _522 & _523;
    assign _520 = ~ _23;
    assign _519 = _11 & _518;
    assign _521 = _519 & _520;
    assign _525 = _521 | _524;
    assign _528 = ~ _23;
    assign _527 = _11 & _526;
    assign _529 = _527 & _528;
    assign _510 = _372[6:6];
    assign _373 = _372[3:3];
    assign _518 = _372[2:2];
    assign _526 = _372[5:5];
    assign _725 = _526 | _518;
    assign _726 = _725 | _373;
    assign _727 = _726 | _506;
    assign _728 = _727 | _510;
    assign _729 = _724 & _728;
    assign _730 = ~ _23;
    assign _731 = _724 & _730;
    assign _744 = 8'b11111111;
    assign _736 = _611 - _714;
    assign _733 = _611 - _714;
    assign _734 = _733 + _704;
    assign _735 = _723 ? _734 : _611;
    assign _737 = _716 ? _736 : _735;
    always @* begin
        case (_737)
        0:
            _745 <= _490;
        1:
            _745 <= _535;
        2:
            _745 <= _536;
        3:
            _745 <= _537;
        4:
            _745 <= _538;
        5:
            _745 <= _539;
        6:
            _745 <= _540;
        7:
            _745 <= _541;
        8:
            _745 <= _744;
        9:
            _745 <= _744;
        10:
            _745 <= _744;
        11:
            _745 <= _744;
        12:
            _745 <= _744;
        13:
            _745 <= _744;
        14:
            _745 <= _744;
        default:
            _745 <= _744;
        endcase
    end
    assign _753 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _749 = { _27,
                    _748 };
    assign _750 = _749[95:32];
    always @(posedge _21) begin
        if (_23)
            _748 <= _753;
        else
            _748 <= _27;
    end
    assign _751 = _533 ? _750 : _748;
    always @(posedge _21) begin
        if (_23)
            _754 <= _753;
        else
            _754 <= _751;
    end
    assign _845 = ~ _23;
    assign _842 = _714 < _704;
    assign _616 = 1'b0;
    assign _713 = 4'b0100;
    assign _712 = 4'b0000;
    assign _506 = _372[4:4];
    assign _709 = _372[1:1];
    assign _710 = _709 | _506;
    assign _371 = _35 ? _14 : _370;
    assign _802 = 7'b0000000;
    assign _797 = { _795,
                    _794 };
    assign _794 = _11 & _35;
    assign _795 = { _794,
                    _794 };
    assign _796 = { _795,
                    _795 };
    assign _798 = { _796,
                    _797 };
    assign _799 = ~ _798;
    assign _787 = { _785,
                    _784 };
    assign _34 = ~ _32;
    assign _33 = _14[0:0];
    assign _35 = _33 & _34;
    assign _782 = ~ _35;
    assign _781 = ~ _32;
    assign _783 = _781 & _782;
    assign _715 = _714 < _611;
    assign _706 = _704 == _712;
    assign _707 = _619 & _706;
    assign _716 = _707 & _715;
    assign _724 = _716 | _723;
    assign _755 = _724 | _32;
    assign _756 = _708 & _755;
    assign _11 = _756;
    assign _784 = _11 & _783;
    assign _785 = { _784,
                    _784 };
    assign _786 = { _785,
                    _785 };
    assign _788 = { _786,
                    _787 };
    assign _789 = ~ _788;
    assign _368 = ~ _23;
    assign _367 = _366 | _319;
    assign _369 = _367 & _368;
    assign _348 = 32'b00100001010001001101111100011100;
    assign _760 = _27[63:32];
    assign _759 = 32'b00000000000000000000000000000000;
    assign _761 = { _759,
                    _760 };
    assign _758 = _52 == _713;
    assign _762 = _758 ? _761 : _27;
    crc32_eth
        crc32_eth
        ( .crc_in(_13),
          .data(_762),
          .octet_count(_335),
          .crc_out(_764[31:0]) );
    assign _12 = _764;
    assign _777 = _775 ? _759 : _347;
    always @(posedge _21) begin
        if (_23)
            _780 <= _759;
        else
            _780 <= _777;
    end
    assign _13 = _780;
    assign _345 = _335 == _712;
    assign _346 = ~ _345;
    assign _347 = _346 ? _12 : _13;
    assign _349 = _347 == _348;
    assign _350 = ~ _349;
    assign _341 = 11'b00000000101;
    assign _342 = _337 < _341;
    assign _343 = ~ _342;
    assign _351 = _343 & _350;
    assign _352 = _326 & _351;
    assign _338 = 11'b00001000000;
    assign _339 = _337 < _338;
    assign _340 = _326 & _339;
    assign _370 = { _340,
                    _352,
                    _319,
                    _357,
                    _364,
                    _326,
                    _369 };
    assign _790 = _370 & _789;
    always @(posedge _21) begin
        if (_23)
            _793 <= _802;
        else
            _793 <= _790;
    end
    assign _14 = _793;
    assign _800 = _14 & _799;
    always @(posedge _21) begin
        if (_23)
            _803 <= _802;
        else
            _803 <= _800;
    end
    assign _15 = _803;
    assign _32 = _15[0:0];
    assign _372 = _32 ? _15 : _371;
    assign _708 = _372[0:0];
    assign _711 = _708 & _710;
    assign _714 = _711 ? _713 : _712;
    assign _721 = _714 < _704;
    assign _722 = ~ _721;
    assign _698 = _578[0:0];
    assign _699 = { _500,
                    _698 };
    assign _695 = _578[1:1];
    assign _696 = { _500,
                    _695 };
    assign _700 = _696 + _699;
    assign _691 = _578[2:2];
    assign _692 = { _500,
                    _691 };
    assign _688 = _578[3:3];
    assign _689 = { _500,
                    _688 };
    assign _693 = _689 + _692;
    assign _701 = _693 + _700;
    assign _683 = _578[4:4];
    assign _684 = { _500,
                    _683 };
    assign _680 = _578[5:5];
    assign _681 = { _500,
                    _680 };
    assign _685 = _681 + _684;
    assign _676 = _578[6:6];
    assign _677 = { _500,
                    _676 };
    assign _673 = _578[7:7];
    assign _674 = { _500,
                    _673 };
    assign _678 = _674 + _677;
    assign _686 = _678 + _685;
    assign _702 = _686 + _701;
    assign _666 = { _662,
                    _665 };
    assign _667 = _666[11:4];
    assign _658 = _41 & _332;
    assign _659 = { _658,
                    _658 };
    assign _660 = { _659,
                    _659 };
    assign _661 = { _660,
                    _660 };
    assign _655 = _647 & _645;
    assign _654 = _647 & _643;
    assign _653 = _647 & _641;
    assign _652 = _647 & _639;
    assign _651 = _647 & _636;
    assign _650 = _647 & _633;
    assign _649 = _647 & _629;
    assign _647 = ~ _620;
    assign _648 = _647 & _625;
    assign _645 = _638 & _635;
    assign _646 = _620 & _645;
    assign _643 = _638 & _632;
    assign _644 = _620 & _643;
    assign _641 = _638 & _628;
    assign _642 = _620 & _641;
    assign _638 = ~ _621;
    assign _639 = _638 & _624;
    assign _640 = _620 & _639;
    assign _635 = _631 & _627;
    assign _636 = _621 & _635;
    assign _637 = _620 & _636;
    assign _631 = ~ _622;
    assign _632 = _631 & _623;
    assign _633 = _621 & _632;
    assign _634 = _620 & _633;
    assign _627 = ~ _623;
    assign _628 = _622 & _627;
    assign _629 = _621 & _628;
    assign _630 = _620 & _629;
    assign _623 = _52[0:0];
    assign _622 = _52[1:1];
    assign _624 = _622 & _623;
    assign _621 = _52[2:2];
    assign _625 = _621 & _624;
    assign _620 = _52[3:3];
    assign _626 = _620 & _625;
    assign _656 = { _626,
                    _630,
                    _634,
                    _637,
                    _640,
                    _642,
                    _644,
                    _646,
                    _648,
                    _649,
                    _650,
                    _651,
                    _652,
                    _653,
                    _654,
                    _655 };
    assign _657 = _656[7:0];
    assign _662 = _657 & _661;
    always @(posedge _21) begin
        if (_23)
            _665 <= _490;
        else
            _665 <= _662;
    end
    assign _668 = _533 ? _667 : _665;
    assign _670 = _668 == _490;
    assign _671 = ~ _670;
    assign _704 = _671 ? _712 : _702;
    assign _718 = _704 == _712;
    assign _719 = ~ _718;
    assign _720 = _619 & _719;
    assign _723 = _720 & _722;
    assign _16 = _723;
    always @(posedge _21) begin
        if (_23)
            _617 <= _616;
        else
            _617 <= _16;
    end
    assign _618 = ~ _617;
    assign _607 = _581[0:0];
    assign _608 = { _500,
                    _607 };
    assign _604 = _581[1:1];
    assign _605 = { _500,
                    _604 };
    assign _609 = _605 + _608;
    assign _600 = _581[2:2];
    assign _601 = { _500,
                    _600 };
    assign _597 = _581[3:3];
    assign _598 = { _500,
                    _597 };
    assign _602 = _598 + _601;
    assign _610 = _602 + _609;
    assign _592 = _581[4:4];
    assign _593 = { _500,
                    _592 };
    assign _589 = _581[5:5];
    assign _590 = { _500,
                    _589 };
    assign _594 = _590 + _593;
    assign _585 = _581[6:6];
    assign _586 = { _500,
                    _585 };
    assign _576 = { _572,
                    _575 };
    assign _577 = _576[11:4];
    assign _569 = { _332,
                    _332 };
    assign _570 = { _569,
                    _569 };
    assign _571 = { _570,
                    _570 };
    assign _558 = 8'b10000000;
    assign _557 = 8'b11000000;
    assign _556 = 8'b11100000;
    assign _555 = 8'b11110000;
    assign _554 = 8'b11111000;
    assign _553 = 8'b11111100;
    assign _552 = 8'b11111110;
    always @* begin
        case (_52)
        0:
            _567 <= _744;
        1:
            _567 <= _552;
        2:
            _567 <= _553;
        3:
            _567 <= _554;
        4:
            _567 <= _555;
        5:
            _567 <= _556;
        6:
            _567 <= _557;
        7:
            _567 <= _558;
        8:
            _567 <= _490;
        9:
            _567 <= _490;
        10:
            _567 <= _490;
        11:
            _567 <= _490;
        12:
            _567 <= _490;
        13:
            _567 <= _490;
        14:
            _567 <= _490;
        default:
            _567 <= _490;
        endcase
    end
    assign _541 = 8'b01111111;
    assign _540 = 8'b00111111;
    assign _539 = 8'b00011111;
    assign _538 = 8'b00001111;
    assign _537 = 8'b00000111;
    assign _536 = 8'b00000011;
    assign _535 = 8'b00000001;
    assign _252 = _239[1:1];
    assign _253 = _252 | _248;
    assign _254 = _253 | _241;
    assign _255 = _254 | _245;
    assign _248 = _239[3:3];
    assign _247 = _239[2:2];
    assign _249 = _247 | _248;
    assign _250 = _249 | _243;
    assign _251 = _250 | _245;
    assign _245 = _239[7:7];
    assign _243 = _239[6:6];
    assign _241 = _239[5:5];
    assign _240 = _239[4:4];
    assign _242 = _240 | _241;
    assign _244 = _242 | _243;
    assign _246 = _244 | _245;
    assign _256 = { _246,
                    _251,
                    _255 };
    assign _257 = { gnd,
                    _256 };
    assign _210 = 4'b1000;
    assign _38 = 2'b00;
    assign _832 = _775 ? _36 : _40;
    assign _828 = _366 ? _38 : _42;
    assign _829 = _319 ? _816 : _828;
    assign _830 = _775 ? _36 : _829;
    assign _353 = _193 & _239;
    assign _355 = _353 == _490;
    assign _356 = ~ _355;
    assign _357 = _321 & _356;
    assign _358 = _198 & _204;
    assign _359 = _151 | _358;
    assign _360 = _359 & _239;
    assign _362 = _360 == _490;
    assign _363 = ~ _362;
    assign _364 = _321 & _363;
    assign _237 = ~ _212;
    assign _238 = _213 & _237;
    assign _235 = ~ _214;
    assign _236 = _215 & _235;
    assign _233 = ~ _216;
    assign _234 = _217 & _233;
    assign _231 = ~ _218;
    assign _232 = _219 & _231;
    assign _229 = ~ _220;
    assign _230 = _221 & _229;
    assign _227 = ~ _222;
    assign _228 = _223 & _227;
    assign _223 = _206[6:6];
    assign _221 = _206[5:5];
    assign _219 = _206[4:4];
    assign _217 = _206[3:3];
    assign _215 = _206[2:2];
    assign _213 = _206[1:1];
    assign _212 = _206[0:0];
    assign _214 = _212 | _213;
    assign _216 = _214 | _215;
    assign _218 = _216 | _217;
    assign _220 = _218 | _219;
    assign _222 = _220 | _221;
    assign _224 = _222 | _223;
    assign _225 = ~ _224;
    assign _211 = _206[7:7];
    assign _226 = _211 & _225;
    assign _239 = { _226,
                    _228,
                    _230,
                    _232,
                    _234,
                    _236,
                    _238,
                    _212 };
    assign _322 = _110 & _239;
    assign _324 = _322 == _490;
    assign _325 = ~ _324;
    assign _320 = ~ _319;
    assign _321 = _44 & _320;
    assign _326 = _321 & _325;
    assign _365 = _326 | _364;
    assign _366 = _365 | _357;
    assign _824 = _366 ? _38 : _40;
    assign _318 = _69 < _210;
    assign _308 = _295[1:1];
    assign _309 = _308 | _304;
    assign _310 = _309 | _297;
    assign _311 = _310 | _301;
    assign _304 = _295[3:3];
    assign _303 = _295[2:2];
    assign _305 = _303 | _304;
    assign _306 = _305 | _299;
    assign _307 = _306 | _301;
    assign _301 = _295[7:7];
    assign _299 = _295[6:6];
    assign _297 = _295[5:5];
    assign _293 = ~ _268;
    assign _294 = _269 & _293;
    assign _291 = ~ _270;
    assign _292 = _271 & _291;
    assign _289 = ~ _272;
    assign _290 = _273 & _289;
    assign _287 = ~ _274;
    assign _288 = _275 & _287;
    assign _285 = ~ _276;
    assign _286 = _277 & _285;
    assign _283 = ~ _278;
    assign _284 = _279 & _283;
    assign _279 = _262[6:6];
    assign _277 = _262[5:5];
    assign _275 = _262[4:4];
    assign _273 = _262[3:3];
    assign _271 = _262[2:2];
    assign _269 = _262[1:1];
    assign _268 = _262[0:0];
    assign _270 = _268 | _269;
    assign _272 = _270 | _271;
    assign _274 = _272 | _273;
    assign _276 = _274 | _275;
    assign _278 = _276 | _277;
    assign _280 = _278 | _279;
    assign _281 = ~ _280;
    assign _267 = _262[7:7];
    assign _282 = _267 & _281;
    assign _295 = { _282,
                    _284,
                    _286,
                    _288,
                    _290,
                    _292,
                    _294,
                    _268 };
    assign _296 = _295[4:4];
    assign _298 = _296 | _297;
    assign _300 = _298 | _299;
    assign _302 = _300 | _301;
    assign _312 = { _302,
                    _307,
                    _311 };
    assign _313 = { gnd,
                    _312 };
    assign _261 = ~ _204;
    assign _262 = _198 & _261;
    assign _264 = _262 == _490;
    assign _265 = ~ _264;
    assign _314 = _265 ? _313 : _210;
    assign _315 = _69 < _314;
    assign _67 = _63[3:0];
    assign _64 = 5'b01000;
    assign _59 = _55[3:0];
    assign _56 = 11'b00000001000;
    assign _807 = 11'b00000000000;
    assign _334 = _331 - _52;
    assign _332 = _52 < _331;
    assign _335 = _332 ? _334 : _712;
    assign _336 = { _802,
                    _335 };
    assign _337 = _17 + _336;
    assign _805 = _775 ? _807 : _337;
    always @(posedge _21) begin
        if (_23)
            _808 <= _807;
        else
            _808 <= _805;
    end
    assign _17 = _808;
    assign _54 = 11'b10111101110;
    assign _55 = _54 - _17;
    assign _57 = _55 < _56;
    assign _58 = ~ _57;
    assign _61 = _58 ? _210 : _59;
    assign _62 = { gnd,
                   _61 };
    always @(posedge _21) begin
        if (_23)
            _811 <= _616;
        else
            if (_775)
                _811 <= _774;
    end
    assign _18 = _811;
    assign _51 = _18 ? _713 : _712;
    assign _48 = _43 ? _712 : _210;
    assign _52 = _41 ? _51 : _48;
    assign _53 = { gnd,
                   _52 };
    assign _63 = _53 + _62;
    assign _65 = _63 < _64;
    assign _66 = ~ _65;
    assign _69 = _66 ? _210 : _67;
    assign _259 = _69 < _258;
    assign _43 = _42 == _40;
    assign _44 = _41 | _43;
    assign _260 = _44 & _259;
    assign _316 = _260 & _315;
    assign _319 = _316 & _318;
    assign _825 = _319 ? _816 : _824;
    assign _826 = _775 ? _36 : _825;
    assign _819 = _110 == _490;
    assign _820 = ~ _819;
    assign _821 = _820 ? _38 : _40;
    assign _822 = _775 ? _36 : _821;
    assign _816 = 2'b11;
    assign _817 = _40 == _816;
    assign _823 = _817 ? _822 : _40;
    assign _42 = 2'b10;
    assign _815 = _40 == _42;
    assign _827 = _815 ? _826 : _823;
    assign _814 = _40 == _36;
    assign _831 = _814 ? _830 : _827;
    assign _813 = _40 == _38;
    assign _833 = _813 ? _832 : _831;
    assign _19 = _833;
    always @(posedge _21) begin
        if (_23)
            _40 <= _38;
        else
            _40 <= _19;
    end
    assign _36 = 2'b01;
    assign _41 = _36 == _40;
    assign _199 = _41 & _18;
    assign _200 = { _199,
                    _199 };
    assign _201 = { _200,
                    _200 };
    assign _202 = { _201,
                    _201 };
    assign _204 = _202 & _538;
    assign _205 = _198 & _204;
    assign _152 = _110 | _151;
    assign _194 = _152 | _193;
    assign _206 = _194 | _205;
    assign _208 = _206 == _490;
    assign _209 = ~ _208;
    assign _258 = _209 ? _257 : _210;
    assign _328 = _258 < _69;
    assign _329 = _328 ? _258 : _69;
    assign _330 = _329 < _314;
    assign _331 = _330 ? _329 : _314;
    always @* begin
        case (_331)
        0:
            _550 <= _490;
        1:
            _550 <= _535;
        2:
            _550 <= _536;
        3:
            _550 <= _537;
        4:
            _550 <= _538;
        5:
            _550 <= _539;
        6:
            _550 <= _540;
        7:
            _550 <= _541;
        8:
            _550 <= _744;
        9:
            _550 <= _744;
        10:
            _550 <= _744;
        11:
            _550 <= _744;
        12:
            _550 <= _744;
        13:
            _550 <= _744;
        14:
            _550 <= _744;
        default:
            _550 <= _744;
        endcase
    end
    assign _568 = _550 & _567;
    assign _572 = _568 & _571;
    always @(posedge _21) begin
        if (_23)
            _575 <= _490;
        else
            _575 <= _572;
    end
    assign gnd = 1'b0;
    assign vdd = 1'b1;
    assign _21 = clock;
    assign _836 = _775 & _774;
    always @(posedge _21) begin
        if (_23)
            _839 <= _616;
        else
            _839 <= _836;
    end
    assign _840 = _839 ? vdd : _533;
    assign _834 = ~ _774;
    assign _440 = _110 | _151;
    assign _441 = _440 | _193;
    assign _442 = _441 | _198;
    assign _444 = _442 & _556;
    assign _771 = _444 == _490;
    assign _772 = ~ _771;
    assign _773 = ~ _772;
    assign _438 = ~ _23;
    assign _436 = _193[4:4];
    assign _437 = _436 & _25;
    assign _439 = _437 & _438;
    assign _774 = _439 & _773;
    assign _195 = _193 | _110;
    assign _196 = _195 | _151;
    assign _197 = ~ _196;
    assign _198 = _29 & _197;
    assign _147 = _27[7:0];
    assign _149 = _147 == _552;
    assign _146 = _29[0:0];
    assign _150 = _146 & _149;
    assign _142 = _27[15:8];
    assign _144 = _142 == _552;
    assign _141 = _29[1:1];
    assign _145 = _141 & _144;
    assign _137 = _27[23:16];
    assign _139 = _137 == _552;
    assign _136 = _29[2:2];
    assign _140 = _136 & _139;
    assign _132 = _27[31:24];
    assign _134 = _132 == _552;
    assign _131 = _29[3:3];
    assign _135 = _131 & _134;
    assign _127 = _27[39:32];
    assign _129 = _127 == _552;
    assign _126 = _29[4:4];
    assign _130 = _126 & _129;
    assign _122 = _27[47:40];
    assign _124 = _122 == _552;
    assign _121 = _29[5:5];
    assign _125 = _121 & _124;
    assign _117 = _27[55:48];
    assign _119 = _117 == _552;
    assign _116 = _29[6:6];
    assign _120 = _116 & _119;
    assign _112 = _27[63:56];
    assign _114 = _112 == _552;
    assign _111 = _29[7:7];
    assign _115 = _111 & _114;
    assign _151 = { _115,
                    _120,
                    _125,
                    _130,
                    _135,
                    _140,
                    _145,
                    _150 };
    assign _107 = 8'b11111101;
    assign _106 = _27[7:0];
    assign _108 = _106 == _107;
    assign _105 = _29[0:0];
    assign _109 = _105 & _108;
    assign _101 = _27[15:8];
    assign _103 = _101 == _107;
    assign _100 = _29[1:1];
    assign _104 = _100 & _103;
    assign _96 = _27[23:16];
    assign _98 = _96 == _107;
    assign _95 = _29[2:2];
    assign _99 = _95 & _98;
    assign _91 = _27[31:24];
    assign _93 = _91 == _107;
    assign _90 = _29[3:3];
    assign _94 = _90 & _93;
    assign _86 = _27[39:32];
    assign _88 = _86 == _107;
    assign _85 = _29[4:4];
    assign _89 = _85 & _88;
    assign _81 = _27[47:40];
    assign _83 = _81 == _107;
    assign _80 = _29[5:5];
    assign _84 = _80 & _83;
    assign _76 = _27[55:48];
    assign _78 = _76 == _107;
    assign _75 = _29[6:6];
    assign _79 = _75 & _78;
    assign _71 = _27[63:56];
    assign _73 = _71 == _107;
    assign _70 = _29[7:7];
    assign _74 = _70 & _73;
    assign _110 = { _74,
                    _79,
                    _84,
                    _89,
                    _94,
                    _99,
                    _104,
                    _109 };
    assign _381 = _110 | _151;
    assign _382 = _381 | _193;
    assign _383 = _382 | _198;
    assign _385 = _383 & _552;
    assign _766 = _385 == _490;
    assign _767 = ~ _766;
    assign _768 = ~ _767;
    assign _23 = clear;
    assign _379 = ~ _23;
    assign _25 = cfg_rx_enable;
    assign _190 = 8'b11111011;
    assign _189 = _27[7:0];
    assign _191 = _189 == _190;
    assign _188 = _29[0:0];
    assign _192 = _188 & _191;
    assign _184 = _27[15:8];
    assign _186 = _184 == _190;
    assign _183 = _29[1:1];
    assign _187 = _183 & _186;
    assign _179 = _27[23:16];
    assign _181 = _179 == _190;
    assign _178 = _29[2:2];
    assign _182 = _178 & _181;
    assign _174 = _27[31:24];
    assign _176 = _174 == _190;
    assign _173 = _29[3:3];
    assign _177 = _173 & _176;
    assign _169 = _27[39:32];
    assign _171 = _169 == _190;
    assign _168 = _29[4:4];
    assign _172 = _168 & _171;
    assign _164 = _27[47:40];
    assign _166 = _164 == _190;
    assign _163 = _29[5:5];
    assign _167 = _163 & _166;
    assign _159 = _27[55:48];
    assign _161 = _159 == _190;
    assign _158 = _29[6:6];
    assign _162 = _158 & _161;
    assign _27 = xgmii_rxd;
    assign _154 = _27[63:56];
    assign _156 = _154 == _190;
    assign _29 = xgmii_rxc;
    assign _153 = _29[7:7];
    assign _157 = _153 & _156;
    assign _193 = { _157,
                    _162,
                    _167,
                    _172,
                    _177,
                    _182,
                    _187,
                    _192 };
    assign _377 = _193[0:0];
    assign _378 = _377 & _25;
    assign _380 = _378 & _379;
    assign _769 = _380 & _768;
    assign _775 = _769 | _774;
    assign _835 = _775 & _834;
    assign _841 = _835 ? gnd : _840;
    assign _30 = _841;
    always @(posedge _21) begin
        if (_23)
            _533 <= _616;
        else
            _533 <= _30;
    end
    assign _578 = _533 ? _577 : _575;
    always @(posedge _21) begin
        if (_23)
            _581 <= _490;
        else
            _581 <= _578;
    end
    assign _582 = _581[7:7];
    assign _583 = { _500,
                    _582 };
    assign _587 = _583 + _586;
    assign _595 = _587 + _594;
    assign _611 = _595 + _610;
    assign _613 = _611 == _712;
    assign _614 = ~ _613;
    assign _619 = _614 & _618;
    assign _843 = _619 & _842;
    assign _844 = _843 | _724;
    assign _846 = _844 & _845;
    assign rx_tvalid = _846;
    assign rx_tdata = _754;
    assign rx_tkeep = _745;
    assign rx_tstrb = _490;
    assign rx_tlast = _731;
    assign rx_tuser = _729;
    assign error_bad_fcs = _529;
    assign error_bad_frame = _525;
    assign error_runt = _517;
    assign error_oversize = _509;
    assign error_start_without_terminate = _505;

endmodule
module xgmii_tx_64 (
    tx_tdata,
    cfg_tx_enable,
    cfg_ifg,
    tx_tkeep,
    tx_tlast,
    tx_tvalid,
    clock,
    clear,
    tx_tstrb,
    tx_tuser,
    tx_tready,
    xgmii_txd,
    xgmii_txc,
    error_underflow
);

    input [63:0] tx_tdata;
    input cfg_tx_enable;
    input [7:0] cfg_ifg;
    input [7:0] tx_tkeep;
    input tx_tlast;
    input tx_tvalid;
    input clock;
    input clear;
    input [7:0] tx_tstrb;
    input tx_tuser;
    output tx_tready;
    output [63:0] xgmii_txd;
    output [7:0] xgmii_txc;
    output error_underflow;

    wire _163;
    wire _46;
    wire _41;
    wire _42;
    wire _44;
    reg _48;
    wire _1;
    wire _161;
    wire _128;
    wire _129;
    wire _130;
    reg _133;
    wire _2;
    wire _158;
    wire _159;
    wire _160;
    wire _162;
    wire _164;
    wire [7:0] _470;
    wire [7:0] _467;
    wire [7:0] _465;
    wire _446;
    wire _461;
    wire _462;
    wire _409;
    wire _424;
    wire _425;
    wire _372;
    wire _387;
    wire _388;
    wire _335;
    wire _350;
    wire _351;
    wire _298;
    wire _313;
    wire _314;
    wire _261;
    wire _276;
    wire _277;
    wire _224;
    wire _239;
    wire _240;
    wire _187;
    wire _202;
    wire _203;
    wire [7:0] _463;
    wire [7:0] _464;
    wire [7:0] _466;
    wire [7:0] _468;
    reg [7:0] _471;
    wire [7:0] _472;
    wire [63:0] _712;
    wire [63:0] _709;
    wire [63:0] _707;
    wire [7:0] _703;
    wire [12:0] _697;
    wire [1:0] _698;
    reg [7:0] _699;
    wire [7:0] _695;
    wire [7:0] _694;
    wire [12:0] _692;
    wire _693;
    wire [7:0] _696;
    wire [11:0] _457;
    wire _455;
    wire _456;
    wire [12:0] _458;
    wire [12:0] _454;
    wire _459;
    wire [11:0] _450;
    wire _448;
    wire _449;
    wire [12:0] _451;
    wire _452;
    wire _453;
    wire _460;
    wire [7:0] _700;
    wire [11:0] _442;
    wire _440;
    wire _441;
    wire [12:0] _443;
    wire _444;
    wire [11:0] _435;
    wire _433;
    wire _434;
    wire [12:0] _436;
    wire _437;
    wire _438;
    wire _445;
    wire [7:0] _702;
    wire [11:0] _429;
    wire _427;
    wire _428;
    wire [12:0] _430;
    wire _431;
    wire [7:0] _704;
    wire [7:0] _690;
    wire [12:0] _684;
    wire [1:0] _685;
    reg [7:0] _686;
    wire [12:0] _679;
    wire _680;
    wire [7:0] _683;
    wire [11:0] _420;
    wire _418;
    wire _419;
    wire [12:0] _421;
    wire [12:0] _417;
    wire _422;
    wire [11:0] _413;
    wire _411;
    wire _412;
    wire [12:0] _414;
    wire _415;
    wire _416;
    wire _423;
    wire [7:0] _687;
    wire [11:0] _405;
    wire _403;
    wire _404;
    wire [12:0] _406;
    wire _407;
    wire [11:0] _398;
    wire _396;
    wire _397;
    wire [12:0] _399;
    wire _400;
    wire _401;
    wire _408;
    wire [7:0] _689;
    wire [11:0] _392;
    wire _390;
    wire _391;
    wire [12:0] _393;
    wire _394;
    wire [7:0] _691;
    wire [7:0] _677;
    wire [12:0] _671;
    wire [1:0] _672;
    reg [7:0] _673;
    wire [12:0] _666;
    wire _667;
    wire [7:0] _670;
    wire [11:0] _383;
    wire _381;
    wire _382;
    wire [12:0] _384;
    wire [12:0] _380;
    wire _385;
    wire [11:0] _376;
    wire _374;
    wire _375;
    wire [12:0] _377;
    wire _378;
    wire _379;
    wire _386;
    wire [7:0] _674;
    wire [11:0] _368;
    wire _366;
    wire _367;
    wire [12:0] _369;
    wire _370;
    wire [11:0] _361;
    wire _359;
    wire _360;
    wire [12:0] _362;
    wire _363;
    wire _364;
    wire _371;
    wire [7:0] _676;
    wire [11:0] _355;
    wire _353;
    wire _354;
    wire [12:0] _356;
    wire _357;
    wire [7:0] _678;
    wire [7:0] _664;
    wire [12:0] _658;
    wire [1:0] _659;
    reg [7:0] _660;
    wire [12:0] _653;
    wire _654;
    wire [7:0] _657;
    wire [11:0] _346;
    wire _344;
    wire _345;
    wire [12:0] _347;
    wire [12:0] _343;
    wire _348;
    wire [11:0] _339;
    wire _337;
    wire _338;
    wire [12:0] _340;
    wire _341;
    wire _342;
    wire _349;
    wire [7:0] _661;
    wire [11:0] _331;
    wire _329;
    wire _330;
    wire [12:0] _332;
    wire _333;
    wire [11:0] _324;
    wire _322;
    wire _323;
    wire [12:0] _325;
    wire _326;
    wire _327;
    wire _334;
    wire [7:0] _663;
    wire [11:0] _318;
    wire _316;
    wire _317;
    wire [12:0] _319;
    wire _320;
    wire [7:0] _665;
    wire [7:0] _651;
    wire [12:0] _645;
    wire [1:0] _646;
    reg [7:0] _647;
    wire [12:0] _640;
    wire _641;
    wire [7:0] _644;
    wire [11:0] _309;
    wire _307;
    wire _308;
    wire [12:0] _310;
    wire [12:0] _306;
    wire _311;
    wire [11:0] _302;
    wire _300;
    wire _301;
    wire [12:0] _303;
    wire _304;
    wire _305;
    wire _312;
    wire [7:0] _648;
    wire [11:0] _294;
    wire _292;
    wire _293;
    wire [12:0] _295;
    wire _296;
    wire [11:0] _287;
    wire _285;
    wire _286;
    wire [12:0] _288;
    wire _289;
    wire _290;
    wire _297;
    wire [7:0] _650;
    wire [11:0] _281;
    wire _279;
    wire _280;
    wire [12:0] _282;
    wire _283;
    wire [7:0] _652;
    wire [7:0] _638;
    wire [12:0] _632;
    wire [1:0] _633;
    reg [7:0] _634;
    wire [12:0] _627;
    wire _628;
    wire [7:0] _631;
    wire [11:0] _272;
    wire _270;
    wire _271;
    wire [12:0] _273;
    wire [12:0] _269;
    wire _274;
    wire [11:0] _265;
    wire _263;
    wire _264;
    wire [12:0] _266;
    wire _267;
    wire _268;
    wire _275;
    wire [7:0] _635;
    wire [11:0] _257;
    wire _255;
    wire _256;
    wire [12:0] _258;
    wire _259;
    wire [11:0] _250;
    wire _248;
    wire _249;
    wire [12:0] _251;
    wire _252;
    wire _253;
    wire _260;
    wire [7:0] _637;
    wire [11:0] _244;
    wire _242;
    wire _243;
    wire [12:0] _245;
    wire _246;
    wire [7:0] _639;
    wire [7:0] _625;
    wire [12:0] _619;
    wire [1:0] _620;
    reg [7:0] _621;
    wire [12:0] _614;
    wire _615;
    wire [7:0] _618;
    wire [11:0] _235;
    wire _233;
    wire _234;
    wire [12:0] _236;
    wire [12:0] _232;
    wire _237;
    wire [11:0] _228;
    wire _226;
    wire _227;
    wire [12:0] _229;
    wire _230;
    wire _231;
    wire _238;
    wire [7:0] _622;
    wire [11:0] _220;
    wire _218;
    wire _219;
    wire [12:0] _221;
    wire _222;
    wire [11:0] _213;
    wire _211;
    wire _212;
    wire [12:0] _214;
    wire _215;
    wire _216;
    wire _223;
    wire [7:0] _624;
    wire [11:0] _207;
    wire _205;
    wire _206;
    wire [12:0] _208;
    wire _209;
    wire [7:0] _626;
    wire [7:0] _612;
    wire [7:0] _607;
    wire [7:0] _606;
    wire [7:0] _605;
    wire _584;
    wire [1:0] _585;
    wire [3:0] _586;
    wire [7:0] _587;
    wire _580;
    wire [1:0] _581;
    wire [3:0] _582;
    wire [7:0] _583;
    wire _576;
    wire [1:0] _577;
    wire [3:0] _578;
    wire [7:0] _579;
    wire _572;
    wire [1:0] _573;
    wire [3:0] _574;
    wire [7:0] _575;
    wire _568;
    wire [1:0] _569;
    wire [3:0] _570;
    wire [7:0] _571;
    wire _564;
    wire [1:0] _565;
    wire [3:0] _566;
    wire [7:0] _567;
    wire _560;
    wire [1:0] _561;
    wire [3:0] _562;
    wire [7:0] _563;
    wire [7:0] _546;
    wire [7:0] _545;
    wire [7:0] _544;
    wire [7:0] _543;
    wire [7:0] _541;
    wire [3:0] _537;
    wire [3:0] _535;
    wire [3:0] _534;
    wire [12:0] _531;
    wire [11:0] _529;
    wire _527;
    wire _528;
    wire [12:0] _530;
    wire _532;
    wire _533;
    wire [3:0] _536;
    wire [11:0] _523;
    wire _521;
    wire _522;
    wire [12:0] _524;
    wire _525;
    wire _526;
    wire [3:0] _538;
    reg [7:0] _555;
    wire _556;
    wire [1:0] _557;
    wire [3:0] _558;
    wire [7:0] _559;
    wire [63:0] _588;
    wire _477;
    wire [63:0] _478;
    wire [1:0] _473;
    wire _474;
    wire _475;
    wire [63:0] _476;
    wire [63:0] _479;
    reg [63:0] _482;
    wire [63:0] _5;
    wire [63:0] _485;
    wire [63:0] _486;
    wire [63:0] _7;
    wire _483;
    wire [63:0] _484;
    wire [63:0] _487;
    reg [63:0] _490;
    wire [63:0] _8;
    wire [63:0] _589;
    wire [31:0] _518;
    wire [31:0] _514;
    wire [31:0] _516;
    reg [31:0] _519;
    wire [31:0] _9;
    wire [31:0] _591;
    wire [31:0] _10;
    reg [31:0] _595;
    wire [31:0] _11;
    wire [3:0] _505;
    wire [11:0] _500;
    wire _498;
    wire _499;
    wire [12:0] _501;
    wire _503;
    wire _504;
    wire [3:0] _507;
    wire [11:0] _494;
    wire _492;
    wire _493;
    wire [12:0] _495;
    wire _496;
    wire _497;
    wire [3:0] _509;
    wire _511;
    wire _512;
    wire _513;
    wire [31:0] _592;
    wire [7:0] _604;
    wire [12:0] _602;
    wire [1:0] _603;
    reg [7:0] _608;
    wire [12:0] _597;
    wire _598;
    wire [7:0] _601;
    wire [11:0] _198;
    wire _196;
    wire _197;
    wire [12:0] _199;
    wire [12:0] _195;
    wire _200;
    wire [11:0] _191;
    wire _189;
    wire _190;
    wire [12:0] _192;
    wire _193;
    wire _194;
    wire _201;
    wire [7:0] _609;
    wire [11:0] _183;
    wire _181;
    wire _182;
    wire [12:0] _184;
    wire _185;
    wire [11:0] _176;
    wire _174;
    wire _175;
    wire [12:0] _177;
    wire _178;
    wire _179;
    wire _186;
    wire [7:0] _611;
    wire [11:0] _170;
    wire [12:0] _167;
    wire _168;
    wire _169;
    wire [12:0] _171;
    wire _172;
    wire [7:0] _613;
    wire [63:0] _705;
    wire [63:0] _596;
    wire [63:0] _706;
    wire [63:0] _708;
    wire [63:0] _710;
    reg [63:0] _713;
    wire [63:0] _714;
    wire _155;
    wire _154;
    wire _156;
    wire _144;
    wire [1:0] _140;
    wire [1:0] _831;
    wire _823;
    wire _122;
    wire _121;
    wire _123;
    wire [1:0] _821;
    wire [1:0] _818;
    wire [1:0] _819;
    wire _808;
    wire _806;
    wire _14;
    wire _802;
    wire _803;
    wire [5:0] _150;
    wire [5:0] _796;
    wire [9:0] _791;
    wire [3:0] _788;
    wire [9:0] _789;
    wire [9:0] _786;
    wire [9:0] _790;
    wire [9:0] _792;
    wire [6:0] _793;
    wire [2:0] _784;
    wire [9:0] _794;
    wire [5:0] _795;
    wire [5:0] _797;
    wire [9:0] _774;
    wire [7:0] _16;
    wire [9:0] _773;
    wire [9:0] _775;
    wire [9:0] _777;
    wire [6:0] _778;
    wire [9:0] _779;
    wire [5:0] _780;
    wire [5:0] _782;
    wire [5:0] _769;
    wire [5:0] _770;
    wire _127;
    wire [5:0] _783;
    wire [11:0] _116;
    wire _114;
    wire _115;
    wire [12:0] _117;
    wire _118;
    wire _119;
    wire [11:0] _107;
    wire [12:0] _100;
    wire [12:0] _97;
    wire [11:0] _95;
    wire [12:0] _91;
    wire _85;
    wire [3:0] _86;
    wire _82;
    wire [3:0] _83;
    wire [3:0] _87;
    wire _78;
    wire [3:0] _79;
    wire _75;
    wire [3:0] _76;
    wire [3:0] _80;
    wire [3:0] _88;
    wire _70;
    wire [3:0] _71;
    wire _67;
    wire [3:0] _68;
    wire [3:0] _72;
    wire _63;
    wire [3:0] _64;
    wire _719;
    wire [7:0] _720;
    wire _716;
    wire _717;
    wire [7:0] _718;
    wire [7:0] _721;
    reg [7:0] _724;
    wire [7:0] _17;
    wire [7:0] _727;
    wire [7:0] _728;
    wire [7:0] _19;
    wire _725;
    wire [7:0] _726;
    wire [7:0] _729;
    reg [7:0] _732;
    wire [7:0] _20;
    wire _60;
    wire [3:0] _61;
    wire [3:0] _65;
    wire [3:0] _73;
    wire [3:0] _89;
    wire [8:0] _58;
    wire [12:0] _90;
    wire [12:0] _733;
    wire [12:0] _734;
    wire [12:0] _735;
    wire [12:0] _737;
    reg [12:0] _740;
    wire [12:0] _21;
    wire [12:0] _741;
    reg [12:0] _744;
    wire [12:0] _22;
    wire [12:0] _56;
    wire _745;
    wire _746;
    reg _749;
    wire _23;
    wire [12:0] _57;
    wire _754;
    wire _755;
    wire _751;
    wire _752;
    wire _753;
    wire _756;
    reg _759;
    wire _24;
    wire _762;
    wire _763;
    wire _26;
    wire _126;
    wire _760;
    wire _761;
    wire _764;
    reg _767;
    wire _27;
    wire _54;
    wire _55;
    wire [12:0] _92;
    wire _93;
    wire _94;
    wire [12:0] _96;
    wire _98;
    wire _99;
    wire [12:0] _101;
    wire [12:0] _102;
    wire [12:0] _104;
    wire _105;
    wire _106;
    wire [12:0] _108;
    wire _110;
    wire _111;
    wire _112;
    wire _120;
    wire [5:0] _798;
    reg [5:0] _801;
    wire [5:0] _28;
    wire _151;
    wire _149;
    wire _152;
    wire _147;
    wire _153;
    wire _804;
    wire _805;
    wire _807;
    wire _809;
    wire _29;
    wire [1:0] _815;
    wire [1:0] _148;
    wire _814;
    wire [1:0] _816;
    wire _813;
    wire [1:0] _817;
    wire _811;
    wire [1:0] _820;
    wire _810;
    wire [1:0] _822;
    wire [1:0] _30;
    reg [1:0] _52;
    wire _53;
    wire _124;
    wire _824;
    wire _31;
    wire [1:0] _828;
    wire _33;
    wire _825;
    wire _34;
    wire gnd;
    wire [1:0] _826;
    wire [1:0] _827;
    wire [1:0] _829;
    reg [1:0] _832;
    wire [1:0] _35;
    wire _141;
    wire _142;
    wire _37;
    wire vdd;
    reg _136;
    wire _137;
    wire _39;
    wire _138;
    wire _139;
    wire _143;
    wire _145;
    wire _157;
    assign _163 = ~ _39;
    assign _46 = 1'b0;
    assign _41 = _34 & _26;
    assign _42 = _1 | _41;
    assign _44 = _29 ? gnd : _42;
    always @(posedge _37) begin
        if (_39)
            _48 <= _46;
        else
            _48 <= _44;
    end
    assign _1 = _48;
    assign _161 = ~ _1;
    assign _128 = _120 | _127;
    assign _129 = _128 ? gnd : _2;
    assign _130 = _29 ? vdd : _129;
    always @(posedge _37) begin
        if (_39)
            _133 <= _46;
        else
            _133 <= _130;
    end
    assign _2 = _133;
    assign _158 = ~ _33;
    assign _159 = _157 & _158;
    assign _160 = _159 & _2;
    assign _162 = _160 & _161;
    assign _164 = _162 & _163;
    assign _470 = 8'b00000000;
    assign _467 = 8'b00000001;
    assign _465 = 8'b11111111;
    assign _446 = _431 | _445;
    assign _461 = _446 | _460;
    assign _462 = ~ _461;
    assign _409 = _394 | _408;
    assign _424 = _409 | _423;
    assign _425 = ~ _424;
    assign _372 = _357 | _371;
    assign _387 = _372 | _386;
    assign _388 = ~ _387;
    assign _335 = _320 | _334;
    assign _350 = _335 | _349;
    assign _351 = ~ _350;
    assign _298 = _283 | _297;
    assign _313 = _298 | _312;
    assign _314 = ~ _313;
    assign _261 = _246 | _260;
    assign _276 = _261 | _275;
    assign _277 = ~ _276;
    assign _224 = _209 | _223;
    assign _239 = _224 | _238;
    assign _240 = ~ _239;
    assign _187 = _172 | _186;
    assign _202 = _187 | _201;
    assign _203 = ~ _202;
    assign _463 = { _203,
                    _240,
                    _277,
                    _314,
                    _351,
                    _388,
                    _425,
                    _462 };
    assign _464 = _53 ? _463 : _465;
    assign _466 = _127 ? _465 : _464;
    assign _468 = _29 ? _467 : _466;
    always @(posedge _37) begin
        if (_39)
            _471 <= _470;
        else
            _471 <= _468;
    end
    assign _472 = _138 ? _465 : _471;
    assign _712 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _709 = 64'b1101010101010101010101010101010101010101010101010101010111111011;
    assign _707 = 64'b0000011100000111000001110000011100000111000001111111110111111110;
    assign _703 = _8[7:0];
    assign _697 = _692 - _102;
    assign _698 = _697[1:0];
    always @* begin
        case (_698)
        0:
            _699 <= _604;
        1:
            _699 <= _605;
        2:
            _699 <= _606;
        default:
            _699 <= _607;
        endcase
    end
    assign _695 = 8'b11111101;
    assign _694 = 8'b00000111;
    assign _692 = 13'b0000000000000;
    assign _693 = _692 == _104;
    assign _696 = _693 ? _695 : _694;
    assign _457 = _104[11:0];
    assign _455 = _104[12:12];
    assign _456 = ~ _455;
    assign _458 = { _456,
                    _457 };
    assign _454 = 13'b1000000000000;
    assign _459 = _454 < _458;
    assign _450 = _102[11:0];
    assign _448 = _102[12:12];
    assign _449 = ~ _448;
    assign _451 = { _449,
                    _450 };
    assign _452 = _454 < _451;
    assign _453 = ~ _452;
    assign _460 = _453 & _459;
    assign _700 = _460 ? _699 : _696;
    assign _442 = _102[11:0];
    assign _440 = _102[12:12];
    assign _441 = ~ _440;
    assign _443 = { _441,
                    _442 };
    assign _444 = _454 < _443;
    assign _435 = _167[11:0];
    assign _433 = _167[12:12];
    assign _434 = ~ _433;
    assign _436 = { _434,
                    _435 };
    assign _437 = _454 < _436;
    assign _438 = ~ _437;
    assign _445 = _438 & _444;
    assign _702 = _445 ? _470 : _700;
    assign _429 = _167[11:0];
    assign _427 = _167[12:12];
    assign _428 = ~ _427;
    assign _430 = { _428,
                    _429 };
    assign _431 = _454 < _430;
    assign _704 = _431 ? _703 : _702;
    assign _690 = _8[15:8];
    assign _684 = _679 - _102;
    assign _685 = _684[1:0];
    always @* begin
        case (_685)
        0:
            _686 <= _604;
        1:
            _686 <= _605;
        2:
            _686 <= _606;
        default:
            _686 <= _607;
        endcase
    end
    assign _679 = 13'b0000000000001;
    assign _680 = _679 == _104;
    assign _683 = _680 ? _695 : _694;
    assign _420 = _104[11:0];
    assign _418 = _104[12:12];
    assign _419 = ~ _418;
    assign _421 = { _419,
                    _420 };
    assign _417 = 13'b1000000000001;
    assign _422 = _417 < _421;
    assign _413 = _102[11:0];
    assign _411 = _102[12:12];
    assign _412 = ~ _411;
    assign _414 = { _412,
                    _413 };
    assign _415 = _417 < _414;
    assign _416 = ~ _415;
    assign _423 = _416 & _422;
    assign _687 = _423 ? _686 : _683;
    assign _405 = _102[11:0];
    assign _403 = _102[12:12];
    assign _404 = ~ _403;
    assign _406 = { _404,
                    _405 };
    assign _407 = _417 < _406;
    assign _398 = _167[11:0];
    assign _396 = _167[12:12];
    assign _397 = ~ _396;
    assign _399 = { _397,
                    _398 };
    assign _400 = _417 < _399;
    assign _401 = ~ _400;
    assign _408 = _401 & _407;
    assign _689 = _408 ? _470 : _687;
    assign _392 = _167[11:0];
    assign _390 = _167[12:12];
    assign _391 = ~ _390;
    assign _393 = { _391,
                    _392 };
    assign _394 = _417 < _393;
    assign _691 = _394 ? _690 : _689;
    assign _677 = _8[23:16];
    assign _671 = _666 - _102;
    assign _672 = _671[1:0];
    always @* begin
        case (_672)
        0:
            _673 <= _604;
        1:
            _673 <= _605;
        2:
            _673 <= _606;
        default:
            _673 <= _607;
        endcase
    end
    assign _666 = 13'b0000000000010;
    assign _667 = _666 == _104;
    assign _670 = _667 ? _695 : _694;
    assign _383 = _104[11:0];
    assign _381 = _104[12:12];
    assign _382 = ~ _381;
    assign _384 = { _382,
                    _383 };
    assign _380 = 13'b1000000000010;
    assign _385 = _380 < _384;
    assign _376 = _102[11:0];
    assign _374 = _102[12:12];
    assign _375 = ~ _374;
    assign _377 = { _375,
                    _376 };
    assign _378 = _380 < _377;
    assign _379 = ~ _378;
    assign _386 = _379 & _385;
    assign _674 = _386 ? _673 : _670;
    assign _368 = _102[11:0];
    assign _366 = _102[12:12];
    assign _367 = ~ _366;
    assign _369 = { _367,
                    _368 };
    assign _370 = _380 < _369;
    assign _361 = _167[11:0];
    assign _359 = _167[12:12];
    assign _360 = ~ _359;
    assign _362 = { _360,
                    _361 };
    assign _363 = _380 < _362;
    assign _364 = ~ _363;
    assign _371 = _364 & _370;
    assign _676 = _371 ? _470 : _674;
    assign _355 = _167[11:0];
    assign _353 = _167[12:12];
    assign _354 = ~ _353;
    assign _356 = { _354,
                    _355 };
    assign _357 = _380 < _356;
    assign _678 = _357 ? _677 : _676;
    assign _664 = _8[31:24];
    assign _658 = _653 - _102;
    assign _659 = _658[1:0];
    always @* begin
        case (_659)
        0:
            _660 <= _604;
        1:
            _660 <= _605;
        2:
            _660 <= _606;
        default:
            _660 <= _607;
        endcase
    end
    assign _653 = 13'b0000000000011;
    assign _654 = _653 == _104;
    assign _657 = _654 ? _695 : _694;
    assign _346 = _104[11:0];
    assign _344 = _104[12:12];
    assign _345 = ~ _344;
    assign _347 = { _345,
                    _346 };
    assign _343 = 13'b1000000000011;
    assign _348 = _343 < _347;
    assign _339 = _102[11:0];
    assign _337 = _102[12:12];
    assign _338 = ~ _337;
    assign _340 = { _338,
                    _339 };
    assign _341 = _343 < _340;
    assign _342 = ~ _341;
    assign _349 = _342 & _348;
    assign _661 = _349 ? _660 : _657;
    assign _331 = _102[11:0];
    assign _329 = _102[12:12];
    assign _330 = ~ _329;
    assign _332 = { _330,
                    _331 };
    assign _333 = _343 < _332;
    assign _324 = _167[11:0];
    assign _322 = _167[12:12];
    assign _323 = ~ _322;
    assign _325 = { _323,
                    _324 };
    assign _326 = _343 < _325;
    assign _327 = ~ _326;
    assign _334 = _327 & _333;
    assign _663 = _334 ? _470 : _661;
    assign _318 = _167[11:0];
    assign _316 = _167[12:12];
    assign _317 = ~ _316;
    assign _319 = { _317,
                    _318 };
    assign _320 = _343 < _319;
    assign _665 = _320 ? _664 : _663;
    assign _651 = _8[39:32];
    assign _645 = _640 - _102;
    assign _646 = _645[1:0];
    always @* begin
        case (_646)
        0:
            _647 <= _604;
        1:
            _647 <= _605;
        2:
            _647 <= _606;
        default:
            _647 <= _607;
        endcase
    end
    assign _640 = 13'b0000000000100;
    assign _641 = _640 == _104;
    assign _644 = _641 ? _695 : _694;
    assign _309 = _104[11:0];
    assign _307 = _104[12:12];
    assign _308 = ~ _307;
    assign _310 = { _308,
                    _309 };
    assign _306 = 13'b1000000000100;
    assign _311 = _306 < _310;
    assign _302 = _102[11:0];
    assign _300 = _102[12:12];
    assign _301 = ~ _300;
    assign _303 = { _301,
                    _302 };
    assign _304 = _306 < _303;
    assign _305 = ~ _304;
    assign _312 = _305 & _311;
    assign _648 = _312 ? _647 : _644;
    assign _294 = _102[11:0];
    assign _292 = _102[12:12];
    assign _293 = ~ _292;
    assign _295 = { _293,
                    _294 };
    assign _296 = _306 < _295;
    assign _287 = _167[11:0];
    assign _285 = _167[12:12];
    assign _286 = ~ _285;
    assign _288 = { _286,
                    _287 };
    assign _289 = _306 < _288;
    assign _290 = ~ _289;
    assign _297 = _290 & _296;
    assign _650 = _297 ? _470 : _648;
    assign _281 = _167[11:0];
    assign _279 = _167[12:12];
    assign _280 = ~ _279;
    assign _282 = { _280,
                    _281 };
    assign _283 = _306 < _282;
    assign _652 = _283 ? _651 : _650;
    assign _638 = _8[47:40];
    assign _632 = _627 - _102;
    assign _633 = _632[1:0];
    always @* begin
        case (_633)
        0:
            _634 <= _604;
        1:
            _634 <= _605;
        2:
            _634 <= _606;
        default:
            _634 <= _607;
        endcase
    end
    assign _627 = 13'b0000000000101;
    assign _628 = _627 == _104;
    assign _631 = _628 ? _695 : _694;
    assign _272 = _104[11:0];
    assign _270 = _104[12:12];
    assign _271 = ~ _270;
    assign _273 = { _271,
                    _272 };
    assign _269 = 13'b1000000000101;
    assign _274 = _269 < _273;
    assign _265 = _102[11:0];
    assign _263 = _102[12:12];
    assign _264 = ~ _263;
    assign _266 = { _264,
                    _265 };
    assign _267 = _269 < _266;
    assign _268 = ~ _267;
    assign _275 = _268 & _274;
    assign _635 = _275 ? _634 : _631;
    assign _257 = _102[11:0];
    assign _255 = _102[12:12];
    assign _256 = ~ _255;
    assign _258 = { _256,
                    _257 };
    assign _259 = _269 < _258;
    assign _250 = _167[11:0];
    assign _248 = _167[12:12];
    assign _249 = ~ _248;
    assign _251 = { _249,
                    _250 };
    assign _252 = _269 < _251;
    assign _253 = ~ _252;
    assign _260 = _253 & _259;
    assign _637 = _260 ? _470 : _635;
    assign _244 = _167[11:0];
    assign _242 = _167[12:12];
    assign _243 = ~ _242;
    assign _245 = { _243,
                    _244 };
    assign _246 = _269 < _245;
    assign _639 = _246 ? _638 : _637;
    assign _625 = _8[55:48];
    assign _619 = _614 - _102;
    assign _620 = _619[1:0];
    always @* begin
        case (_620)
        0:
            _621 <= _604;
        1:
            _621 <= _605;
        2:
            _621 <= _606;
        default:
            _621 <= _607;
        endcase
    end
    assign _614 = 13'b0000000000110;
    assign _615 = _614 == _104;
    assign _618 = _615 ? _695 : _694;
    assign _235 = _104[11:0];
    assign _233 = _104[12:12];
    assign _234 = ~ _233;
    assign _236 = { _234,
                    _235 };
    assign _232 = 13'b1000000000110;
    assign _237 = _232 < _236;
    assign _228 = _102[11:0];
    assign _226 = _102[12:12];
    assign _227 = ~ _226;
    assign _229 = { _227,
                    _228 };
    assign _230 = _232 < _229;
    assign _231 = ~ _230;
    assign _238 = _231 & _237;
    assign _622 = _238 ? _621 : _618;
    assign _220 = _102[11:0];
    assign _218 = _102[12:12];
    assign _219 = ~ _218;
    assign _221 = { _219,
                    _220 };
    assign _222 = _232 < _221;
    assign _213 = _167[11:0];
    assign _211 = _167[12:12];
    assign _212 = ~ _211;
    assign _214 = { _212,
                    _213 };
    assign _215 = _232 < _214;
    assign _216 = ~ _215;
    assign _223 = _216 & _222;
    assign _624 = _223 ? _470 : _622;
    assign _207 = _167[11:0];
    assign _205 = _167[12:12];
    assign _206 = ~ _205;
    assign _208 = { _206,
                    _207 };
    assign _209 = _232 < _208;
    assign _626 = _209 ? _625 : _624;
    assign _612 = _8[63:56];
    assign _607 = _592[31:24];
    assign _606 = _592[23:16];
    assign _605 = _592[15:8];
    assign _584 = _555[0:0];
    assign _585 = { _584,
                    _584 };
    assign _586 = { _585,
                    _585 };
    assign _587 = { _586,
                    _586 };
    assign _580 = _555[1:1];
    assign _581 = { _580,
                    _580 };
    assign _582 = { _581,
                    _581 };
    assign _583 = { _582,
                    _582 };
    assign _576 = _555[2:2];
    assign _577 = { _576,
                    _576 };
    assign _578 = { _577,
                    _577 };
    assign _579 = { _578,
                    _578 };
    assign _572 = _555[3:3];
    assign _573 = { _572,
                    _572 };
    assign _574 = { _573,
                    _573 };
    assign _575 = { _574,
                    _574 };
    assign _568 = _555[4:4];
    assign _569 = { _568,
                    _568 };
    assign _570 = { _569,
                    _569 };
    assign _571 = { _570,
                    _570 };
    assign _564 = _555[5:5];
    assign _565 = { _564,
                    _564 };
    assign _566 = { _565,
                    _565 };
    assign _567 = { _566,
                    _566 };
    assign _560 = _555[6:6];
    assign _561 = { _560,
                    _560 };
    assign _562 = { _561,
                    _561 };
    assign _563 = { _562,
                    _562 };
    assign _546 = 8'b01111111;
    assign _545 = 8'b00111111;
    assign _544 = 8'b00011111;
    assign _543 = 8'b00001111;
    assign _541 = 8'b00000011;
    assign _537 = 4'b0000;
    assign _535 = 4'b1000;
    assign _534 = _167[3:0];
    assign _531 = 13'b1000000001000;
    assign _529 = _167[11:0];
    assign _527 = _167[12:12];
    assign _528 = ~ _527;
    assign _530 = { _528,
                    _529 };
    assign _532 = _530 < _531;
    assign _533 = ~ _532;
    assign _536 = _533 ? _535 : _534;
    assign _523 = _167[11:0];
    assign _521 = _167[12:12];
    assign _522 = ~ _521;
    assign _524 = { _522,
                    _523 };
    assign _525 = _454 < _524;
    assign _526 = ~ _525;
    assign _538 = _526 ? _537 : _536;
    always @* begin
        case (_538)
        0:
            _555 <= _470;
        1:
            _555 <= _467;
        2:
            _555 <= _541;
        3:
            _555 <= _694;
        4:
            _555 <= _543;
        5:
            _555 <= _544;
        6:
            _555 <= _545;
        7:
            _555 <= _546;
        8:
            _555 <= _465;
        9:
            _555 <= _465;
        10:
            _555 <= _465;
        11:
            _555 <= _465;
        12:
            _555 <= _465;
        13:
            _555 <= _465;
        14:
            _555 <= _465;
        default:
            _555 <= _465;
        endcase
    end
    assign _556 = _555[7:7];
    assign _557 = { _556,
                    _556 };
    assign _558 = { _557,
                    _557 };
    assign _559 = { _558,
                    _558 };
    assign _588 = { _559,
                    _563,
                    _567,
                    _571,
                    _575,
                    _579,
                    _583,
                    _587 };
    assign _477 = _141 & _34;
    assign _478 = _477 ? _7 : _5;
    assign _473 = 2'b01;
    assign _474 = _35 == _473;
    assign _475 = _474 & _34;
    assign _476 = _475 ? _7 : _5;
    assign _479 = _31 ? _478 : _476;
    always @(posedge _37) begin
        if (_39)
            _482 <= _712;
        else
            _482 <= _479;
    end
    assign _5 = _482;
    assign _485 = _34 ? _7 : _8;
    assign _486 = _141 ? _5 : _485;
    assign _7 = tx_tdata;
    assign _483 = _126 & _34;
    assign _484 = _483 ? _7 : _8;
    assign _487 = _31 ? _486 : _484;
    always @(posedge _37) begin
        if (_39)
            _490 <= _712;
        else
            _490 <= _487;
    end
    assign _8 = _490;
    assign _589 = _8 & _588;
    assign _518 = 32'b00000000000000000000000000000000;
    assign _514 = _513 ? _10 : _9;
    assign _516 = _29 ? _518 : _514;
    always @(posedge _37) begin
        if (_39)
            _519 <= _518;
        else
            _519 <= _516;
    end
    assign _9 = _519;
    crc32_eth
        crc32_eth
        ( .crc_in(_9),
          .data(_589),
          .octet_count(_509),
          .crc_out(_591[31:0]) );
    assign _10 = _591;
    always @(posedge _37) begin
        if (_39)
            _595 <= _518;
        else
            _595 <= _592;
    end
    assign _11 = _595;
    assign _505 = _102[3:0];
    assign _500 = _102[11:0];
    assign _498 = _102[12:12];
    assign _499 = ~ _498;
    assign _501 = { _499,
                    _500 };
    assign _503 = _501 < _531;
    assign _504 = ~ _503;
    assign _507 = _504 ? _535 : _505;
    assign _494 = _102[11:0];
    assign _492 = _102[12:12];
    assign _493 = ~ _492;
    assign _495 = { _493,
                    _494 };
    assign _496 = _454 < _495;
    assign _497 = ~ _496;
    assign _509 = _497 ? _537 : _507;
    assign _511 = _509 == _537;
    assign _512 = ~ _511;
    assign _513 = _53 & _512;
    assign _592 = _513 ? _10 : _11;
    assign _604 = _592[7:0];
    assign _602 = _597 - _102;
    assign _603 = _602[1:0];
    always @* begin
        case (_603)
        0:
            _608 <= _604;
        1:
            _608 <= _605;
        2:
            _608 <= _606;
        default:
            _608 <= _607;
        endcase
    end
    assign _597 = 13'b0000000000111;
    assign _598 = _597 == _104;
    assign _601 = _598 ? _695 : _694;
    assign _198 = _104[11:0];
    assign _196 = _104[12:12];
    assign _197 = ~ _196;
    assign _199 = { _197,
                    _198 };
    assign _195 = 13'b1000000000111;
    assign _200 = _195 < _199;
    assign _191 = _102[11:0];
    assign _189 = _102[12:12];
    assign _190 = ~ _189;
    assign _192 = { _190,
                    _191 };
    assign _193 = _195 < _192;
    assign _194 = ~ _193;
    assign _201 = _194 & _200;
    assign _609 = _201 ? _608 : _601;
    assign _183 = _102[11:0];
    assign _181 = _102[12:12];
    assign _182 = ~ _181;
    assign _184 = { _182,
                    _183 };
    assign _185 = _195 < _184;
    assign _176 = _167[11:0];
    assign _174 = _167[12:12];
    assign _175 = ~ _174;
    assign _177 = { _175,
                    _176 };
    assign _178 = _195 < _177;
    assign _179 = ~ _178;
    assign _186 = _179 & _185;
    assign _611 = _186 ? _470 : _609;
    assign _170 = _167[11:0];
    assign _167 = _92 - _21;
    assign _168 = _167[12:12];
    assign _169 = ~ _168;
    assign _171 = { _169,
                    _170 };
    assign _172 = _195 < _171;
    assign _613 = _172 ? _612 : _611;
    assign _705 = { _613,
                    _626,
                    _639,
                    _652,
                    _665,
                    _678,
                    _691,
                    _704 };
    assign _596 = 64'b0000011100000111000001110000011100000111000001110000011100000111;
    assign _706 = _53 ? _705 : _596;
    assign _708 = _127 ? _707 : _706;
    assign _710 = _29 ? _709 : _708;
    always @(posedge _37) begin
        if (_39)
            _713 <= _712;
        else
            _713 <= _710;
    end
    assign _714 = _138 ? _596 : _713;
    assign _155 = _53 & _124;
    assign _154 = _153 & _14;
    assign _156 = _154 | _155;
    assign _144 = ~ _127;
    assign _140 = 2'b10;
    assign _831 = 2'b00;
    assign _823 = ~ _126;
    assign _122 = _21 < _22;
    assign _121 = ~ _23;
    assign _123 = _121 | _122;
    assign _821 = _29 ? _473 : _52;
    assign _818 = _120 ? _148 : _52;
    assign _819 = _127 ? _140 : _818;
    assign _808 = ~ _39;
    assign _806 = ~ _138;
    assign _14 = cfg_tx_enable;
    assign _802 = ~ _126;
    assign _803 = _802 | _34;
    assign _150 = 6'b000000;
    assign _796 = 6'b000001;
    assign _791 = 10'b0000000111;
    assign _788 = _104[3:0];
    assign _789 = { _150,
                    _788 };
    assign _786 = { _831,
                    _16 };
    assign _790 = _786 + _789;
    assign _792 = _790 + _791;
    assign _793 = _792[9:3];
    assign _784 = 3'b000;
    assign _794 = { _784,
                    _793 };
    assign _795 = _794[5:0];
    assign _797 = _795 - _796;
    assign _774 = 10'b0000000001;
    assign _16 = cfg_ifg;
    assign _773 = { _831,
                    _16 };
    assign _775 = _773 + _774;
    assign _777 = _775 + _791;
    assign _778 = _777[9:3];
    assign _779 = { _784,
                    _778 };
    assign _780 = _779[5:0];
    assign _782 = _780 - _796;
    assign _769 = _28 - _796;
    assign _770 = _151 ? _28 : _769;
    assign _127 = _124 & _126;
    assign _783 = _127 ? _782 : _770;
    assign _116 = _104[11:0];
    assign _114 = _104[12:12];
    assign _115 = ~ _114;
    assign _117 = { _115,
                    _116 };
    assign _118 = _195 < _117;
    assign _119 = ~ _118;
    assign _107 = _104[11:0];
    assign _100 = 13'b0000000111100;
    assign _97 = 13'b1000000111100;
    assign _95 = _92[11:0];
    assign _91 = _21 + _90;
    assign _85 = _20[0:0];
    assign _86 = { _784,
                   _85 };
    assign _82 = _20[1:1];
    assign _83 = { _784,
                   _82 };
    assign _87 = _83 + _86;
    assign _78 = _20[2:2];
    assign _79 = { _784,
                   _78 };
    assign _75 = _20[3:3];
    assign _76 = { _784,
                   _75 };
    assign _80 = _76 + _79;
    assign _88 = _80 + _87;
    assign _70 = _20[4:4];
    assign _71 = { _784,
                   _70 };
    assign _67 = _20[5:5];
    assign _68 = { _784,
                   _67 };
    assign _72 = _68 + _71;
    assign _63 = _20[6:6];
    assign _64 = { _784,
                   _63 };
    assign _719 = _141 & _34;
    assign _720 = _719 ? _19 : _17;
    assign _716 = _35 == _473;
    assign _717 = _716 & _34;
    assign _718 = _717 ? _19 : _17;
    assign _721 = _31 ? _720 : _718;
    always @(posedge _37) begin
        if (_39)
            _724 <= _470;
        else
            _724 <= _721;
    end
    assign _17 = _724;
    assign _727 = _34 ? _19 : _20;
    assign _728 = _141 ? _17 : _727;
    assign _19 = tx_tkeep;
    assign _725 = _126 & _34;
    assign _726 = _725 ? _19 : _20;
    assign _729 = _31 ? _728 : _726;
    always @(posedge _37) begin
        if (_39)
            _732 <= _470;
        else
            _732 <= _729;
    end
    assign _20 = _732;
    assign _60 = _20[7:7];
    assign _61 = { _784,
                   _60 };
    assign _65 = _61 + _64;
    assign _73 = _65 + _72;
    assign _89 = _73 + _88;
    assign _58 = 9'b000000000;
    assign _90 = { _58,
                   _89 };
    assign _733 = 13'b0000000001000;
    assign _734 = _21 + _733;
    assign _735 = _53 ? _734 : _21;
    assign _737 = _29 ? _692 : _735;
    always @(posedge _37) begin
        if (_39)
            _740 <= _692;
        else
            _740 <= _737;
    end
    assign _21 = _740;
    assign _741 = _21 + _90;
    always @(posedge _37) begin
        if (_39)
            _744 <= _692;
        else
            if (_55)
                _744 <= _741;
    end
    assign _22 = _744;
    assign _56 = 13'b0111110100000;
    assign _745 = _23 | _55;
    assign _746 = _29 ? gnd : _745;
    always @(posedge _37) begin
        if (_39)
            _749 <= _46;
        else
            _749 <= _746;
    end
    assign _23 = _749;
    assign _57 = _23 ? _22 : _56;
    assign _754 = _141 & _34;
    assign _755 = _754 ? _26 : _24;
    assign _751 = _35 == _473;
    assign _752 = _751 & _34;
    assign _753 = _752 ? _26 : _24;
    assign _756 = _31 ? _755 : _753;
    always @(posedge _37) begin
        if (_39)
            _759 <= _46;
        else
            _759 <= _756;
    end
    assign _24 = _759;
    assign _762 = _34 ? _26 : _27;
    assign _763 = _141 ? _24 : _762;
    assign _26 = tx_tlast;
    assign _126 = _35 == _831;
    assign _760 = _126 & _34;
    assign _761 = _760 ? _26 : _27;
    assign _764 = _31 ? _763 : _761;
    always @(posedge _37) begin
        if (_39)
            _767 <= _46;
        else
            _767 <= _764;
    end
    assign _27 = _767;
    assign _54 = _53 & _31;
    assign _55 = _54 & _27;
    assign _92 = _55 ? _91 : _57;
    assign _93 = _92[12:12];
    assign _94 = ~ _93;
    assign _96 = { _94,
                   _95 };
    assign _98 = _96 < _97;
    assign _99 = ~ _98;
    assign _101 = _99 ? _92 : _100;
    assign _102 = _101 - _21;
    assign _104 = _102 + _640;
    assign _105 = _104[12:12];
    assign _106 = ~ _105;
    assign _108 = { _106,
                    _107 };
    assign _110 = _108 < _454;
    assign _111 = ~ _110;
    assign _112 = _53 & _111;
    assign _120 = _112 & _119;
    assign _798 = _120 ? _797 : _783;
    always @(posedge _37) begin
        if (_39)
            _801 <= _150;
        else
            _801 <= _798;
    end
    assign _28 = _801;
    assign _151 = _28 == _150;
    assign _149 = _148 == _52;
    assign _152 = _149 & _151;
    assign _147 = _831 == _52;
    assign _153 = _147 | _152;
    assign _804 = _153 & _803;
    assign _805 = _804 & _14;
    assign _807 = _805 & _806;
    assign _809 = _807 & _808;
    assign _29 = _809;
    assign _815 = _29 ? _473 : _52;
    assign _148 = 2'b11;
    assign _814 = _52 == _148;
    assign _816 = _814 ? _815 : _52;
    assign _813 = _52 == _140;
    assign _817 = _813 ? _148 : _816;
    assign _811 = _52 == _473;
    assign _820 = _811 ? _819 : _817;
    assign _810 = _52 == _831;
    assign _822 = _810 ? _821 : _820;
    assign _30 = _822;
    always @(posedge _37) begin
        if (_39)
            _52 <= _831;
        else
            _52 <= _30;
    end
    assign _53 = _473 == _52;
    assign _124 = _53 & _123;
    assign _824 = _124 & _823;
    assign _31 = _824;
    assign _828 = { gnd,
                    _31 };
    assign _33 = tx_tvalid;
    assign _825 = _157 & _33;
    assign _34 = _825;
    assign gnd = 1'b0;
    assign _826 = { gnd,
                    _34 };
    assign _827 = _35 + _826;
    assign _829 = _827 - _828;
    always @(posedge _37) begin
        if (_39)
            _832 <= _831;
        else
            _832 <= _829;
    end
    assign _35 = _832;
    assign _141 = _35 == _140;
    assign _142 = ~ _141;
    assign _37 = clock;
    assign vdd = 1'b1;
    always @(posedge _37) begin
        if (_39)
            _136 <= _46;
        else
            _136 <= vdd;
    end
    assign _137 = ~ _136;
    assign _39 = clear;
    assign _138 = _39 | _137;
    assign _139 = ~ _138;
    assign _143 = _139 & _142;
    assign _145 = _143 & _144;
    assign _157 = _145 & _156;
    assign tx_tready = _157;
    assign xgmii_txd = _714;
    assign xgmii_txc = _472;
    assign error_underflow = _164;

endmodule
module eth_mac_10g (
    cfg_tx_enable,
    cfg_ifg,
    tx_tuser,
    tx_tlast,
    tx_tstrb,
    tx_tkeep,
    tx_tdata,
    tx_tvalid,
    cfg_rx_enable,
    xgmii_rxc,
    xgmii_rxd,
    clear,
    clock,
    rx_tvalid,
    rx_tdata,
    rx_tkeep,
    rx_tstrb,
    rx_tlast,
    rx_tuser,
    tx_tready,
    xgmii_txd,
    xgmii_txc,
    error_bad_fcs,
    error_bad_frame,
    error_runt,
    error_oversize,
    error_start_without_terminate,
    error_underflow
);

    input cfg_tx_enable;
    input [7:0] cfg_ifg;
    input tx_tuser;
    input tx_tlast;
    input [7:0] tx_tstrb;
    input [7:0] tx_tkeep;
    input [63:0] tx_tdata;
    input tx_tvalid;
    input cfg_rx_enable;
    input [7:0] xgmii_rxc;
    input [63:0] xgmii_rxd;
    input clear;
    input clock;
    output rx_tvalid;
    output [63:0] rx_tdata;
    output [7:0] rx_tkeep;
    output [7:0] rx_tstrb;
    output rx_tlast;
    output rx_tuser;
    output tx_tready;
    output [63:0] xgmii_txd;
    output [7:0] xgmii_txc;
    output error_bad_fcs;
    output error_bad_frame;
    output error_runt;
    output error_oversize;
    output error_start_without_terminate;
    output error_underflow;

    wire _44;
    wire _47;
    wire _48;
    wire _49;
    wire _50;
    wire _51;
    wire [7:0] _52;
    wire [63:0] _53;
    wire _10;
    wire [7:0] _12;
    wire _14;
    wire _16;
    wire [7:0] _18;
    wire [7:0] _20;
    wire [63:0] _22;
    wire _24;
    wire [73:0] _43;
    wire _54;
    wire _55;
    wire _56;
    wire [7:0] _57;
    wire [7:0] _58;
    wire [63:0] _59;
    wire _32;
    wire [7:0] _34;
    wire [63:0] _36;
    wire _38;
    wire _40;
    wire [87:0] _46;
    wire _60;
    assign _44 = _43[73:73];
    assign _47 = _46[87:87];
    assign _48 = _46[86:86];
    assign _49 = _46[85:85];
    assign _50 = _46[84:84];
    assign _51 = _46[83:83];
    assign _52 = _43[72:65];
    assign _53 = _43[64:1];
    assign _10 = cfg_tx_enable;
    assign _12 = cfg_ifg;
    assign _14 = tx_tuser;
    assign _16 = tx_tlast;
    assign _18 = tx_tstrb;
    assign _20 = tx_tkeep;
    assign _22 = tx_tdata;
    assign _24 = tx_tvalid;
    xgmii_tx_64
        tx
        ( .clock(_40),
          .clear(_38),
          .tx_tvalid(_24),
          .tx_tdata(_22),
          .tx_tkeep(_20),
          .tx_tstrb(_18),
          .tx_tlast(_16),
          .tx_tuser(_14),
          .cfg_ifg(_12),
          .cfg_tx_enable(_10),
          .error_underflow(_43[73:73]),
          .xgmii_txc(_43[72:65]),
          .xgmii_txd(_43[64:1]),
          .tx_tready(_43[0:0]) );
    assign _54 = _43[0:0];
    assign _55 = _46[82:82];
    assign _56 = _46[81:81];
    assign _57 = _46[80:73];
    assign _58 = _46[72:65];
    assign _59 = _46[64:1];
    assign _32 = cfg_rx_enable;
    assign _34 = xgmii_rxc;
    assign _36 = xgmii_rxd;
    assign _38 = clear;
    assign _40 = clock;
    xgmii_rx_64
        rx
        ( .clock(_40),
          .clear(_38),
          .xgmii_rxd(_36),
          .xgmii_rxc(_34),
          .cfg_rx_enable(_32),
          .error_start_without_terminate(_46[87:87]),
          .error_oversize(_46[86:86]),
          .error_runt(_46[85:85]),
          .error_bad_frame(_46[84:84]),
          .error_bad_fcs(_46[83:83]),
          .rx_tuser(_46[82:82]),
          .rx_tlast(_46[81:81]),
          .rx_tstrb(_46[80:73]),
          .rx_tkeep(_46[72:65]),
          .rx_tdata(_46[64:1]),
          .rx_tvalid(_46[0:0]) );
    assign _60 = _46[0:0];
    assign rx_tvalid = _60;
    assign rx_tdata = _59;
    assign rx_tkeep = _58;
    assign rx_tstrb = _57;
    assign rx_tlast = _56;
    assign rx_tuser = _55;
    assign tx_tready = _54;
    assign xgmii_txd = _53;
    assign xgmii_txc = _52;
    assign error_bad_fcs = _51;
    assign error_bad_frame = _50;
    assign error_runt = _49;
    assign error_oversize = _48;
    assign error_start_without_terminate = _47;
    assign error_underflow = _44;

endmodule
