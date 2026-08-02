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
    clear,
    clock,
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

    input clear;
    input clock;
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

    wire _453;
    wire _452;
    wire _454;
    wire _457;
    wire _456;
    wire _458;
    wire _461;
    wire _460;
    wire _462;
    wire _465;
    wire _464;
    wire _466;
    wire _469;
    wire _468;
    wire _470;
    wire _459;
    wire _451;
    wire _463;
    wire _467;
    wire _652;
    wire _653;
    wire _654;
    wire _655;
    wire _656;
    wire _657;
    wire _658;
    wire [7:0] _659;
    wire [7:0] _671;
    wire [3:0] _663;
    wire [3:0] _660;
    wire [3:0] _661;
    wire [3:0] _662;
    wire [3:0] _664;
    reg [7:0] _672;
    wire [63:0] _680;
    wire [127:0] _676;
    wire [63:0] _677;
    reg [63:0] _675;
    wire [63:0] _678;
    reg [63:0] _681;
    wire _794;
    wire [3:0] _640;
    wire [3:0] _639;
    wire _455;
    wire _636;
    wire _637;
    wire [6:0] _449;
    wire [6:0] _721;
    wire [2:0] _716;
    wire _713;
    wire [1:0] _714;
    wire [3:0] _715;
    wire [6:0] _717;
    wire [6:0] _718;
    wire [2:0] _706;
    wire _33;
    wire _32;
    wire _34;
    wire _701;
    wire _700;
    wire _702;
    wire _648;
    wire _649;
    wire _645;
    wire _646;
    wire _647;
    wire _650;
    wire _642;
    wire _625;
    wire [2:0] _624;
    wire [3:0] _626;
    wire _622;
    wire [3:0] _623;
    wire [3:0] _627;
    wire _618;
    wire [3:0] _619;
    wire _615;
    wire [3:0] _616;
    wire [3:0] _620;
    wire [3:0] _628;
    wire _610;
    wire [3:0] _611;
    wire _607;
    wire [3:0] _608;
    wire [3:0] _612;
    wire _603;
    wire [3:0] _604;
    wire _600;
    wire [3:0] _601;
    wire [3:0] _605;
    wire [3:0] _613;
    wire [3:0] _629;
    wire [15:0] _593;
    wire [7:0] _594;
    wire _585;
    wire [1:0] _586;
    wire [3:0] _587;
    wire [7:0] _588;
    wire _582;
    wire _581;
    wire _580;
    wire _579;
    wire _578;
    wire _577;
    wire _576;
    wire _574;
    wire _575;
    wire _572;
    wire _573;
    wire _570;
    wire _571;
    wire _568;
    wire _569;
    wire _565;
    wire _566;
    wire _567;
    wire _562;
    wire _563;
    wire _564;
    wire _558;
    wire _559;
    wire _560;
    wire _561;
    wire _554;
    wire _555;
    wire _556;
    wire _557;
    wire _550;
    wire _549;
    wire _551;
    wire _548;
    wire _552;
    wire _547;
    wire _553;
    wire [15:0] _583;
    wire [7:0] _584;
    wire [7:0] _589;
    reg [7:0] _592;
    wire [7:0] _595;
    wire _597;
    wire _598;
    wire [3:0] _631;
    wire _633;
    wire _634;
    wire _643;
    wire _651;
    wire _682;
    wire _683;
    wire _11;
    wire _703;
    wire [1:0] _704;
    wire [3:0] _705;
    wire [6:0] _707;
    wire [6:0] _708;
    wire _446;
    wire _444;
    wire _445;
    wire _447;
    wire [31:0] _421;
    wire [31:0] _418;
    wire [31:0] _687;
    wire [63:0] _688;
    wire _685;
    wire [63:0] _689;
    wire [31:0] _691;
    wire [31:0] _12;
    wire [31:0] _694;
    wire [31:0] _696;
    reg [31:0] _699;
    wire [31:0] _13;
    wire [31:0] _419;
    wire _416;
    wire _417;
    wire [31:0] _420;
    wire _422;
    wire _423;
    wire _424;
    wire [10:0] _412;
    wire _413;
    wire _393;
    wire _414;
    wire [6:0] _448;
    wire [6:0] _709;
    reg [6:0] _712;
    wire [6:0] _14;
    wire [6:0] _719;
    reg [6:0] _722;
    wire [6:0] _15;
    wire _31;
    wire [6:0] _450;
    wire _635;
    wire _638;
    wire [3:0] _641;
    wire _791;
    wire _539;
    wire [3:0] _540;
    wire _536;
    wire [3:0] _537;
    wire [3:0] _541;
    wire _532;
    wire [3:0] _533;
    wire _529;
    wire [3:0] _530;
    wire [3:0] _534;
    wire [3:0] _542;
    wire _524;
    wire [3:0] _525;
    wire _521;
    wire [3:0] _522;
    wire [3:0] _526;
    wire _517;
    wire [3:0] _518;
    wire [15:0] _508;
    wire [7:0] _509;
    wire [1:0] _501;
    wire [3:0] _502;
    wire [7:0] _503;
    reg [7:0] _499;
    wire [7:0] _482;
    wire [7:0] _481;
    wire [7:0] _480;
    wire [7:0] _479;
    wire [7:0] _478;
    wire [7:0] _477;
    wire [7:0] _476;
    reg [7:0] _491;
    wire [7:0] _500;
    wire [7:0] _504;
    reg [7:0] _507;
    wire _473;
    wire _785;
    reg _788;
    wire _789;
    wire _783;
    wire _753;
    wire _395;
    wire [1:0] _78;
    wire [1:0] _781;
    wire [1:0] _777;
    wire [1:0] _778;
    wire [1:0] _779;
    wire _441;
    wire _442;
    wire _443;
    wire [1:0] _773;
    wire [3:0] _428;
    wire _429;
    wire _426;
    wire _425;
    wire _427;
    wire _430;
    wire _772;
    wire [1:0] _774;
    wire [1:0] _775;
    wire _767;
    wire _768;
    wire [1:0] _769;
    wire _764;
    wire [7:0] _436;
    wire _438;
    wire _439;
    wire _440;
    wire [7:0] _379;
    wire _381;
    wire _382;
    wire [3:0] _373;
    wire [4:0] _370;
    wire [3:0] _365;
    wire [10:0] _362;
    wire vdd;
    wire [10:0] _726;
    wire [3:0] _408;
    wire _402;
    wire [3:0] _403;
    wire _404;
    wire [3:0] _405;
    wire _406;
    wire [3:0] _409;
    wire [10:0] _410;
    wire [10:0] _400;
    wire [10:0] _411;
    wire _692;
    wire _693;
    wire [10:0] _724;
    reg [10:0] _727;
    wire [10:0] _16;
    wire [10:0] _360;
    wire [10:0] _361;
    wire _363;
    wire _364;
    wire [3:0] _367;
    wire [4:0] _368;
    wire _18;
    wire _20;
    wire _741;
    wire _742;
    wire _743;
    wire _744;
    wire _737;
    wire _736;
    wire _738;
    wire _739;
    wire _740;
    wire _734;
    wire _732;
    wire _730;
    wire _729;
    wire _731;
    wire _733;
    wire _735;
    wire [2:0] _745;
    wire [3:0] _746;
    wire _22;
    wire _387;
    wire _386;
    wire _388;
    wire _385;
    wire _389;
    wire _390;
    wire _391;
    wire _384;
    wire _392;
    wire [7:0] _431;
    wire _433;
    wire _434;
    wire _435;
    wire _728;
    wire [3:0] _747;
    wire _749;
    reg _755;
    wire _23;
    wire [3:0] _357;
    wire _351;
    wire [3:0] _354;
    wire _349;
    wire [3:0] _358;
    wire [4:0] _359;
    wire [4:0] _369;
    wire _371;
    wire _372;
    wire [3:0] _375;
    wire _376;
    wire _377;
    wire _340;
    wire _341;
    wire _342;
    wire _343;
    wire _336;
    wire _335;
    wire _337;
    wire _338;
    wire _339;
    wire _333;
    wire _331;
    wire _329;
    wire _325;
    wire _326;
    wire _323;
    wire _324;
    wire _321;
    wire _322;
    wire _319;
    wire _320;
    wire _317;
    wire _318;
    wire _315;
    wire _316;
    wire _311;
    wire _309;
    wire _307;
    wire _305;
    wire _303;
    wire _301;
    wire _300;
    wire _302;
    wire _304;
    wire _306;
    wire _308;
    wire _310;
    wire _312;
    wire _313;
    wire _299;
    wire _314;
    wire [7:0] _327;
    wire _328;
    wire _330;
    wire _332;
    wire _334;
    wire [2:0] _344;
    wire [3:0] _345;
    wire [7:0] _290;
    wire [7:0] _291;
    wire [7:0] _292;
    wire [7:0] _293;
    wire [7:0] _294;
    wire _296;
    wire _297;
    wire [3:0] _346;
    wire _283;
    wire _284;
    wire _285;
    wire _286;
    wire _279;
    wire _278;
    wire _280;
    wire _281;
    wire _282;
    wire _276;
    wire _274;
    wire _272;
    wire _268;
    wire _269;
    wire _266;
    wire _267;
    wire _264;
    wire _265;
    wire _262;
    wire _263;
    wire _260;
    wire _261;
    wire _258;
    wire _259;
    wire _254;
    wire _252;
    wire _250;
    wire _248;
    wire _246;
    wire _244;
    wire _243;
    wire _245;
    wire _247;
    wire _249;
    wire _251;
    wire _253;
    wire _255;
    wire _256;
    wire _242;
    wire _257;
    wire [7:0] _270;
    wire _271;
    wire _273;
    wire _275;
    wire _277;
    wire [2:0] _287;
    wire [3:0] _288;
    wire [7:0] _236;
    wire [7:0] _230;
    wire [7:0] _229;
    wire _231;
    wire _228;
    wire _232;
    wire [7:0] _224;
    wire _226;
    wire _223;
    wire _227;
    wire [7:0] _219;
    wire _221;
    wire _218;
    wire _222;
    wire [7:0] _214;
    wire _216;
    wire _213;
    wire _217;
    wire [7:0] _209;
    wire _211;
    wire _208;
    wire _212;
    wire [7:0] _204;
    wire _206;
    wire _203;
    wire _207;
    wire [7:0] _199;
    wire _201;
    wire _198;
    wire _202;
    wire [7:0] _194;
    wire _196;
    wire _193;
    wire _197;
    wire [7:0] _233;
    wire [7:0] _234;
    wire [7:0] _182;
    wire [7:0] _181;
    wire [7:0] _180;
    wire [7:0] _179;
    wire [7:0] _178;
    wire [7:0] _177;
    wire [3:0] _172;
    wire _166;
    wire _167;
    wire _168;
    wire _169;
    wire _162;
    wire _161;
    wire _163;
    wire _164;
    wire _165;
    wire _159;
    wire _157;
    wire _155;
    wire _151;
    wire _152;
    wire _149;
    wire _150;
    wire _147;
    wire _148;
    wire _145;
    wire _146;
    wire _143;
    wire _144;
    wire _141;
    wire _142;
    wire _137;
    wire _135;
    wire _133;
    wire _131;
    wire _129;
    wire _127;
    wire _126;
    wire _128;
    wire _130;
    wire _132;
    wire _134;
    wire _136;
    wire _138;
    wire _139;
    wire [7:0] _121;
    wire [7:0] _120;
    wire _122;
    wire _119;
    wire _123;
    wire [7:0] _115;
    wire _117;
    wire _114;
    wire _118;
    wire [7:0] _110;
    wire _112;
    wire _109;
    wire _113;
    wire [7:0] _105;
    wire _107;
    wire _104;
    wire _108;
    wire [7:0] _100;
    wire _102;
    wire _99;
    wire _103;
    wire [7:0] _95;
    wire _97;
    wire _94;
    wire _98;
    wire [7:0] _90;
    wire _92;
    wire _89;
    wire _93;
    wire [7:0] _85;
    wire _87;
    wire _84;
    wire _88;
    wire [7:0] _124;
    wire _125;
    wire _140;
    wire [7:0] _153;
    wire _154;
    wire _156;
    wire _158;
    wire _160;
    wire [2:0] _170;
    wire gnd;
    wire [3:0] _171;
    wire [3:0] _173;
    wire [3:0] _174;
    reg [7:0] _191;
    wire [7:0] _72;
    wire [7:0] _71;
    wire _73;
    wire _70;
    wire _74;
    wire [7:0] _66;
    wire _68;
    wire _65;
    wire _69;
    wire [7:0] _61;
    wire _63;
    wire _60;
    wire _64;
    wire [7:0] _56;
    wire _58;
    wire _55;
    wire _59;
    wire [7:0] _51;
    wire _53;
    wire _50;
    wire _54;
    wire [7:0] _46;
    wire _48;
    wire _45;
    wire _49;
    wire [7:0] _41;
    wire _43;
    wire _40;
    wire _44;
    wire [63:0] _25;
    wire [7:0] _36;
    wire _38;
    wire [7:0] _27;
    wire _35;
    wire _39;
    wire [7:0] _75;
    wire [7:0] _192;
    wire [7:0] _235;
    wire [7:0] _237;
    wire _239;
    wire _240;
    wire [3:0] _289;
    wire _347;
    wire _378;
    wire _383;
    wire _760;
    wire _761;
    wire _762;
    wire _763;
    wire _765;
    wire [1:0] _770;
    wire [1:0] _394;
    wire _759;
    wire [1:0] _771;
    wire [1:0] _350;
    wire _758;
    wire [1:0] _776;
    wire [1:0] _348;
    wire _757;
    wire [1:0] _780;
    wire _756;
    wire [1:0] _782;
    wire [1:0] _28;
    reg [1:0] _80;
    wire _81;
    wire _396;
    wire _397;
    wire _398;
    wire _752;
    wire _754;
    wire _784;
    wire _790;
    wire _29;
    reg _474;
    wire [7:0] _510;
    reg [7:0] _513;
    wire _514;
    wire [3:0] _515;
    wire [3:0] _519;
    wire [3:0] _527;
    wire [3:0] _543;
    wire _545;
    wire _546;
    wire _792;
    wire _793;
    wire _795;
    assign _453 = ~ _18;
    assign _452 = _11 & _451;
    assign _454 = _452 & _453;
    assign _457 = ~ _18;
    assign _456 = _11 & _455;
    assign _458 = _456 & _457;
    assign _461 = ~ _18;
    assign _460 = _11 & _459;
    assign _462 = _460 & _461;
    assign _465 = ~ _18;
    assign _464 = _11 & _463;
    assign _466 = _464 & _465;
    assign _469 = ~ _18;
    assign _468 = _11 & _467;
    assign _470 = _468 & _469;
    assign _459 = _450[6:6];
    assign _451 = _450[3:3];
    assign _463 = _450[2:2];
    assign _467 = _450[5:5];
    assign _652 = _467 | _463;
    assign _653 = _652 | _451;
    assign _654 = _653 | _455;
    assign _655 = _654 | _459;
    assign _656 = _651 & _655;
    assign _657 = ~ _18;
    assign _658 = _651 & _657;
    assign _659 = 8'b00000000;
    assign _671 = 8'b11111111;
    assign _663 = _543 - _641;
    assign _660 = _543 - _641;
    assign _661 = _660 + _631;
    assign _662 = _650 ? _661 : _543;
    assign _664 = _643 ? _663 : _662;
    always @* begin
        case (_664)
        0:
            _672 <= _659;
        1:
            _672 <= _476;
        2:
            _672 <= _477;
        3:
            _672 <= _478;
        4:
            _672 <= _479;
        5:
            _672 <= _480;
        6:
            _672 <= _481;
        7:
            _672 <= _482;
        8:
            _672 <= _671;
        9:
            _672 <= _671;
        10:
            _672 <= _671;
        11:
            _672 <= _671;
        12:
            _672 <= _671;
        13:
            _672 <= _671;
        14:
            _672 <= _671;
        default:
            _672 <= _671;
        endcase
    end
    assign _680 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _676 = { _25,
                    _675 };
    assign _677 = _676[95:32];
    always @(posedge _20) begin
        if (_18)
            _675 <= _680;
        else
            _675 <= _25;
    end
    assign _678 = _474 ? _677 : _675;
    always @(posedge _20) begin
        if (_18)
            _681 <= _680;
        else
            _681 <= _678;
    end
    assign _794 = ~ _18;
    assign _640 = 4'b0100;
    assign _639 = 4'b0000;
    assign _455 = _450[4:4];
    assign _636 = _450[1:1];
    assign _637 = _636 | _455;
    assign _449 = _34 ? _14 : _448;
    assign _721 = 7'b0000000;
    assign _716 = { _714,
                    _713 };
    assign _713 = _11 & _34;
    assign _714 = { _713,
                    _713 };
    assign _715 = { _714,
                    _714 };
    assign _717 = { _715,
                    _716 };
    assign _718 = ~ _717;
    assign _706 = { _704,
                    _703 };
    assign _33 = ~ _31;
    assign _32 = _14[0:0];
    assign _34 = _32 & _33;
    assign _701 = ~ _34;
    assign _700 = ~ _31;
    assign _702 = _700 & _701;
    assign _648 = _641 < _631;
    assign _649 = ~ _648;
    assign _645 = _631 == _639;
    assign _646 = ~ _645;
    assign _647 = _546 & _646;
    assign _650 = _647 & _649;
    assign _642 = _641 < _543;
    assign _625 = _510[0:0];
    assign _624 = 3'b000;
    assign _626 = { _624,
                    _625 };
    assign _622 = _510[1:1];
    assign _623 = { _624,
                    _622 };
    assign _627 = _623 + _626;
    assign _618 = _510[2:2];
    assign _619 = { _624,
                    _618 };
    assign _615 = _510[3:3];
    assign _616 = { _624,
                    _615 };
    assign _620 = _616 + _619;
    assign _628 = _620 + _627;
    assign _610 = _510[4:4];
    assign _611 = { _624,
                    _610 };
    assign _607 = _510[5:5];
    assign _608 = { _624,
                    _607 };
    assign _612 = _608 + _611;
    assign _603 = _510[6:6];
    assign _604 = { _624,
                    _603 };
    assign _600 = _510[7:7];
    assign _601 = { _624,
                    _600 };
    assign _605 = _601 + _604;
    assign _613 = _605 + _612;
    assign _629 = _613 + _628;
    assign _593 = { _589,
                    _592 };
    assign _594 = _593[11:4];
    assign _585 = _349 & _406;
    assign _586 = { _585,
                    _585 };
    assign _587 = { _586,
                    _586 };
    assign _588 = { _587,
                    _587 };
    assign _582 = _574 & _572;
    assign _581 = _574 & _570;
    assign _580 = _574 & _568;
    assign _579 = _574 & _566;
    assign _578 = _574 & _563;
    assign _577 = _574 & _560;
    assign _576 = _574 & _556;
    assign _574 = ~ _547;
    assign _575 = _574 & _552;
    assign _572 = _565 & _562;
    assign _573 = _547 & _572;
    assign _570 = _565 & _559;
    assign _571 = _547 & _570;
    assign _568 = _565 & _555;
    assign _569 = _547 & _568;
    assign _565 = ~ _548;
    assign _566 = _565 & _551;
    assign _567 = _547 & _566;
    assign _562 = _558 & _554;
    assign _563 = _548 & _562;
    assign _564 = _547 & _563;
    assign _558 = ~ _549;
    assign _559 = _558 & _550;
    assign _560 = _548 & _559;
    assign _561 = _547 & _560;
    assign _554 = ~ _550;
    assign _555 = _549 & _554;
    assign _556 = _548 & _555;
    assign _557 = _547 & _556;
    assign _550 = _358[0:0];
    assign _549 = _358[1:1];
    assign _551 = _549 & _550;
    assign _548 = _358[2:2];
    assign _552 = _548 & _551;
    assign _547 = _358[3:3];
    assign _553 = _547 & _552;
    assign _583 = { _553,
                    _557,
                    _561,
                    _564,
                    _567,
                    _569,
                    _571,
                    _573,
                    _575,
                    _576,
                    _577,
                    _578,
                    _579,
                    _580,
                    _581,
                    _582 };
    assign _584 = _583[7:0];
    assign _589 = _584 & _588;
    always @(posedge _20) begin
        if (_18)
            _592 <= _659;
        else
            _592 <= _589;
    end
    assign _595 = _474 ? _594 : _592;
    assign _597 = _595 == _659;
    assign _598 = ~ _597;
    assign _631 = _598 ? _639 : _629;
    assign _633 = _631 == _639;
    assign _634 = _546 & _633;
    assign _643 = _634 & _642;
    assign _651 = _643 | _650;
    assign _682 = _651 | _31;
    assign _683 = _635 & _682;
    assign _11 = _683;
    assign _703 = _11 & _702;
    assign _704 = { _703,
                    _703 };
    assign _705 = { _704,
                    _704 };
    assign _707 = { _705,
                    _706 };
    assign _708 = ~ _707;
    assign _446 = ~ _18;
    assign _444 = _430 & _392;
    assign _445 = _443 | _444;
    assign _447 = _445 & _446;
    assign _421 = 32'b00100001010001001101111100011100;
    assign _418 = 32'b00000000000000000000000000000000;
    assign _687 = _25[63:32];
    assign _688 = { _418,
                    _687 };
    assign _685 = _358 == _640;
    assign _689 = _685 ? _688 : _25;
    crc32_eth
        crc32_eth
        ( .crc_in(_419),
          .data(_689),
          .octet_count(_409),
          .crc_out(_691[31:0]) );
    assign _12 = _691;
    assign _694 = _417 ? _12 : _419;
    assign _696 = _693 ? _418 : _694;
    always @(posedge _20) begin
        if (_18)
            _699 <= _418;
        else
            _699 <= _696;
    end
    assign _13 = _699;
    assign _419 = _398 ? _418 : _13;
    assign _416 = _409 == _639;
    assign _417 = ~ _416;
    assign _420 = _417 ? _12 : _419;
    assign _422 = _420 == _421;
    assign _423 = ~ _422;
    assign _424 = _383 & _423;
    assign _412 = 11'b00001000000;
    assign _413 = _411 < _412;
    assign _393 = _383 & _392;
    assign _414 = _393 & _413;
    assign _448 = { _414,
                    _424,
                    _430,
                    _435,
                    _440,
                    _383,
                    _447 };
    assign _709 = _448 & _708;
    always @(posedge _20) begin
        if (_18)
            _712 <= _721;
        else
            _712 <= _709;
    end
    assign _14 = _712;
    assign _719 = _14 & _718;
    always @(posedge _20) begin
        if (_18)
            _722 <= _721;
        else
            _722 <= _719;
    end
    assign _15 = _722;
    assign _31 = _15[0:0];
    assign _450 = _31 ? _15 : _449;
    assign _635 = _450[0:0];
    assign _638 = _635 & _637;
    assign _641 = _638 ? _640 : _639;
    assign _791 = _641 < _631;
    assign _539 = _513[0:0];
    assign _540 = { _624,
                    _539 };
    assign _536 = _513[1:1];
    assign _537 = { _624,
                    _536 };
    assign _541 = _537 + _540;
    assign _532 = _513[2:2];
    assign _533 = { _624,
                    _532 };
    assign _529 = _513[3:3];
    assign _530 = { _624,
                    _529 };
    assign _534 = _530 + _533;
    assign _542 = _534 + _541;
    assign _524 = _513[4:4];
    assign _525 = { _624,
                    _524 };
    assign _521 = _513[5:5];
    assign _522 = { _624,
                    _521 };
    assign _526 = _522 + _525;
    assign _517 = _513[6:6];
    assign _518 = { _624,
                    _517 };
    assign _508 = { _504,
                    _507 };
    assign _509 = _508[11:4];
    assign _501 = { _406,
                    _406 };
    assign _502 = { _501,
                    _501 };
    assign _503 = { _502,
                    _502 };
    always @* begin
        case (_358)
        0:
            _499 <= _671;
        1:
            _499 <= _230;
        2:
            _499 <= _177;
        3:
            _499 <= _178;
        4:
            _499 <= _179;
        5:
            _499 <= _180;
        6:
            _499 <= _181;
        7:
            _499 <= _182;
        8:
            _499 <= _659;
        9:
            _499 <= _659;
        10:
            _499 <= _659;
        11:
            _499 <= _659;
        12:
            _499 <= _659;
        13:
            _499 <= _659;
        14:
            _499 <= _659;
        default:
            _499 <= _659;
        endcase
    end
    assign _482 = 8'b01111111;
    assign _481 = 8'b00111111;
    assign _480 = 8'b00011111;
    assign _479 = 8'b00001111;
    assign _478 = 8'b00000111;
    assign _477 = 8'b00000011;
    assign _476 = 8'b00000001;
    always @* begin
        case (_405)
        0:
            _491 <= _659;
        1:
            _491 <= _476;
        2:
            _491 <= _477;
        3:
            _491 <= _478;
        4:
            _491 <= _479;
        5:
            _491 <= _480;
        6:
            _491 <= _481;
        7:
            _491 <= _482;
        8:
            _491 <= _671;
        9:
            _491 <= _671;
        10:
            _491 <= _671;
        11:
            _491 <= _671;
        12:
            _491 <= _671;
        13:
            _491 <= _671;
        14:
            _491 <= _671;
        default:
            _491 <= _671;
        endcase
    end
    assign _500 = _491 & _499;
    assign _504 = _500 & _503;
    always @(posedge _20) begin
        if (_18)
            _507 <= _659;
        else
            _507 <= _504;
    end
    assign _473 = 1'b0;
    assign _785 = _754 & _749;
    always @(posedge _20) begin
        if (_18)
            _788 <= _473;
        else
            _788 <= _785;
    end
    assign _789 = _788 ? vdd : _474;
    assign _783 = ~ _749;
    assign _753 = ~ _18;
    assign _395 = _394 == _80;
    assign _78 = 2'b00;
    assign _781 = _765 ? _348 : _80;
    assign _777 = _443 ? _78 : _350;
    assign _778 = _772 ? _394 : _777;
    assign _779 = _765 ? _348 : _778;
    assign _441 = _383 | _440;
    assign _442 = _441 | _435;
    assign _443 = _442 & _392;
    assign _773 = _443 ? _78 : _80;
    assign _428 = 4'b1000;
    assign _429 = _375 < _428;
    assign _426 = _375 < _346;
    assign _425 = _375 < _289;
    assign _427 = _425 & _426;
    assign _430 = _427 & _429;
    assign _772 = _430 & _392;
    assign _774 = _772 ? _394 : _773;
    assign _775 = _765 ? _348 : _774;
    assign _767 = _75 == _659;
    assign _768 = ~ _767;
    assign _769 = _768 ? _78 : _80;
    assign _764 = ~ _18;
    assign _436 = _234 & _270;
    assign _438 = _436 == _659;
    assign _439 = ~ _438;
    assign _440 = _378 & _439;
    assign _379 = _192 & _270;
    assign _381 = _379 == _659;
    assign _382 = ~ _381;
    assign _373 = _369[3:0];
    assign _370 = 5'b01000;
    assign _365 = _361[3:0];
    assign _362 = 11'b00000001000;
    assign vdd = 1'b1;
    assign _726 = 11'b00000000000;
    assign _408 = _405 - _358;
    assign _402 = _289 < _375;
    assign _403 = _402 ? _289 : _375;
    assign _404 = _403 < _346;
    assign _405 = _404 ? _403 : _346;
    assign _406 = _358 < _405;
    assign _409 = _406 ? _408 : _639;
    assign _410 = { _721,
                    _409 };
    assign _400 = _398 ? _726 : _16;
    assign _411 = _400 + _410;
    assign _692 = _435 & _392;
    assign _693 = _692 & _22;
    assign _724 = _693 ? _726 : _411;
    always @(posedge _20) begin
        if (_18)
            _727 <= _726;
        else
            _727 <= _724;
    end
    assign _16 = _727;
    assign _360 = 11'b10111101110;
    assign _361 = _360 - _16;
    assign _363 = _361 < _362;
    assign _364 = ~ _363;
    assign _367 = _364 ? _428 : _365;
    assign _368 = { gnd,
                    _367 };
    assign _18 = clear;
    assign _20 = clock;
    assign _741 = _270[1:1];
    assign _742 = _741 | _737;
    assign _743 = _742 | _730;
    assign _744 = _743 | _734;
    assign _737 = _270[3:3];
    assign _736 = _270[2:2];
    assign _738 = _736 | _737;
    assign _739 = _738 | _732;
    assign _740 = _739 | _734;
    assign _734 = _270[7:7];
    assign _732 = _270[6:6];
    assign _730 = _270[5:5];
    assign _729 = _270[4:4];
    assign _731 = _729 | _730;
    assign _733 = _731 | _732;
    assign _735 = _733 | _734;
    assign _745 = { _735,
                    _740,
                    _744 };
    assign _746 = { gnd,
                    _745 };
    assign _22 = cfg_rx_enable;
    assign _387 = ~ _385;
    assign _386 = _124[4:4];
    assign _388 = _386 & _387;
    assign _385 = _124[0:0];
    assign _389 = _385 | _388;
    assign _390 = _389 & _22;
    assign _391 = _81 & _390;
    assign _384 = _349 | _351;
    assign _392 = _384 | _391;
    assign _431 = _236 & _270;
    assign _433 = _431 == _659;
    assign _434 = ~ _433;
    assign _435 = _378 & _434;
    assign _728 = _435 & _392;
    assign _747 = _728 ? _746 : _171;
    assign _749 = _747 == _640;
    always @(posedge _20) begin
        if (_18)
            _755 <= _473;
        else
            if (_754)
                _755 <= _749;
    end
    assign _23 = _755;
    assign _357 = _23 ? _640 : _639;
    assign _351 = _350 == _80;
    assign _354 = _351 ? _639 : _428;
    assign _349 = _348 == _80;
    assign _358 = _349 ? _357 : _354;
    assign _359 = { gnd,
                    _358 };
    assign _369 = _359 + _368;
    assign _371 = _369 < _370;
    assign _372 = ~ _371;
    assign _375 = _372 ? _428 : _373;
    assign _376 = _375 < _289;
    assign _377 = ~ _376;
    assign _340 = _327[1:1];
    assign _341 = _340 | _336;
    assign _342 = _341 | _329;
    assign _343 = _342 | _333;
    assign _336 = _327[3:3];
    assign _335 = _327[2:2];
    assign _337 = _335 | _336;
    assign _338 = _337 | _331;
    assign _339 = _338 | _333;
    assign _333 = _327[7:7];
    assign _331 = _327[6:6];
    assign _329 = _327[5:5];
    assign _325 = ~ _300;
    assign _326 = _301 & _325;
    assign _323 = ~ _302;
    assign _324 = _303 & _323;
    assign _321 = ~ _304;
    assign _322 = _305 & _321;
    assign _319 = ~ _306;
    assign _320 = _307 & _319;
    assign _317 = ~ _308;
    assign _318 = _309 & _317;
    assign _315 = ~ _310;
    assign _316 = _311 & _315;
    assign _311 = _294[6:6];
    assign _309 = _294[5:5];
    assign _307 = _294[4:4];
    assign _305 = _294[3:3];
    assign _303 = _294[2:2];
    assign _301 = _294[1:1];
    assign _300 = _294[0:0];
    assign _302 = _300 | _301;
    assign _304 = _302 | _303;
    assign _306 = _304 | _305;
    assign _308 = _306 | _307;
    assign _310 = _308 | _309;
    assign _312 = _310 | _311;
    assign _313 = ~ _312;
    assign _299 = _294[7:7];
    assign _314 = _299 & _313;
    assign _327 = { _314,
                    _316,
                    _318,
                    _320,
                    _322,
                    _324,
                    _326,
                    _300 };
    assign _328 = _327[4:4];
    assign _330 = _328 | _329;
    assign _332 = _330 | _331;
    assign _334 = _332 | _333;
    assign _344 = { _334,
                    _339,
                    _343 };
    assign _345 = { gnd,
                    _344 };
    assign _290 = _124 | _75;
    assign _291 = _290 | _233;
    assign _292 = ~ _291;
    assign _293 = _27 & _292;
    assign _294 = _293 & _191;
    assign _296 = _294 == _659;
    assign _297 = ~ _296;
    assign _346 = _297 ? _345 : _428;
    assign _283 = _270[1:1];
    assign _284 = _283 | _279;
    assign _285 = _284 | _272;
    assign _286 = _285 | _276;
    assign _279 = _270[3:3];
    assign _278 = _270[2:2];
    assign _280 = _278 | _279;
    assign _281 = _280 | _274;
    assign _282 = _281 | _276;
    assign _276 = _270[7:7];
    assign _274 = _270[6:6];
    assign _272 = _270[5:5];
    assign _268 = ~ _243;
    assign _269 = _244 & _268;
    assign _266 = ~ _245;
    assign _267 = _246 & _266;
    assign _264 = ~ _247;
    assign _265 = _248 & _264;
    assign _262 = ~ _249;
    assign _263 = _250 & _262;
    assign _260 = ~ _251;
    assign _261 = _252 & _260;
    assign _258 = ~ _253;
    assign _259 = _254 & _258;
    assign _254 = _237[6:6];
    assign _252 = _237[5:5];
    assign _250 = _237[4:4];
    assign _248 = _237[3:3];
    assign _246 = _237[2:2];
    assign _244 = _237[1:1];
    assign _243 = _237[0:0];
    assign _245 = _243 | _244;
    assign _247 = _245 | _246;
    assign _249 = _247 | _248;
    assign _251 = _249 | _250;
    assign _253 = _251 | _252;
    assign _255 = _253 | _254;
    assign _256 = ~ _255;
    assign _242 = _237[7:7];
    assign _257 = _242 & _256;
    assign _270 = { _257,
                    _259,
                    _261,
                    _263,
                    _265,
                    _267,
                    _269,
                    _243 };
    assign _271 = _270[4:4];
    assign _273 = _271 | _272;
    assign _275 = _273 | _274;
    assign _277 = _275 | _276;
    assign _287 = { _277,
                    _282,
                    _286 };
    assign _288 = { gnd,
                    _287 };
    assign _236 = _124 & _191;
    assign _230 = 8'b11111110;
    assign _229 = _25[7:0];
    assign _231 = _229 == _230;
    assign _228 = _27[0:0];
    assign _232 = _228 & _231;
    assign _224 = _25[15:8];
    assign _226 = _224 == _230;
    assign _223 = _27[1:1];
    assign _227 = _223 & _226;
    assign _219 = _25[23:16];
    assign _221 = _219 == _230;
    assign _218 = _27[2:2];
    assign _222 = _218 & _221;
    assign _214 = _25[31:24];
    assign _216 = _214 == _230;
    assign _213 = _27[3:3];
    assign _217 = _213 & _216;
    assign _209 = _25[39:32];
    assign _211 = _209 == _230;
    assign _208 = _27[4:4];
    assign _212 = _208 & _211;
    assign _204 = _25[47:40];
    assign _206 = _204 == _230;
    assign _203 = _27[5:5];
    assign _207 = _203 & _206;
    assign _199 = _25[55:48];
    assign _201 = _199 == _230;
    assign _198 = _27[6:6];
    assign _202 = _198 & _201;
    assign _194 = _25[63:56];
    assign _196 = _194 == _230;
    assign _193 = _27[7:7];
    assign _197 = _193 & _196;
    assign _233 = { _197,
                    _202,
                    _207,
                    _212,
                    _217,
                    _222,
                    _227,
                    _232 };
    assign _234 = _233 & _191;
    assign _182 = 8'b10000000;
    assign _181 = 8'b11000000;
    assign _180 = 8'b11100000;
    assign _179 = 8'b11110000;
    assign _178 = 8'b11111000;
    assign _177 = 8'b11111100;
    assign _172 = 4'b0001;
    assign _166 = _153[1:1];
    assign _167 = _166 | _162;
    assign _168 = _167 | _155;
    assign _169 = _168 | _159;
    assign _162 = _153[3:3];
    assign _161 = _153[2:2];
    assign _163 = _161 | _162;
    assign _164 = _163 | _157;
    assign _165 = _164 | _159;
    assign _159 = _153[7:7];
    assign _157 = _153[6:6];
    assign _155 = _153[5:5];
    assign _151 = ~ _126;
    assign _152 = _127 & _151;
    assign _149 = ~ _128;
    assign _150 = _129 & _149;
    assign _147 = ~ _130;
    assign _148 = _131 & _147;
    assign _145 = ~ _132;
    assign _146 = _133 & _145;
    assign _143 = ~ _134;
    assign _144 = _135 & _143;
    assign _141 = ~ _136;
    assign _142 = _137 & _141;
    assign _137 = _124[6:6];
    assign _135 = _124[5:5];
    assign _133 = _124[4:4];
    assign _131 = _124[3:3];
    assign _129 = _124[2:2];
    assign _127 = _124[1:1];
    assign _126 = _124[0:0];
    assign _128 = _126 | _127;
    assign _130 = _128 | _129;
    assign _132 = _130 | _131;
    assign _134 = _132 | _133;
    assign _136 = _134 | _135;
    assign _138 = _136 | _137;
    assign _139 = ~ _138;
    assign _121 = 8'b11111011;
    assign _120 = _25[7:0];
    assign _122 = _120 == _121;
    assign _119 = _27[0:0];
    assign _123 = _119 & _122;
    assign _115 = _25[15:8];
    assign _117 = _115 == _121;
    assign _114 = _27[1:1];
    assign _118 = _114 & _117;
    assign _110 = _25[23:16];
    assign _112 = _110 == _121;
    assign _109 = _27[2:2];
    assign _113 = _109 & _112;
    assign _105 = _25[31:24];
    assign _107 = _105 == _121;
    assign _104 = _27[3:3];
    assign _108 = _104 & _107;
    assign _100 = _25[39:32];
    assign _102 = _100 == _121;
    assign _99 = _27[4:4];
    assign _103 = _99 & _102;
    assign _95 = _25[47:40];
    assign _97 = _95 == _121;
    assign _94 = _27[5:5];
    assign _98 = _94 & _97;
    assign _90 = _25[55:48];
    assign _92 = _90 == _121;
    assign _89 = _27[6:6];
    assign _93 = _89 & _92;
    assign _85 = _25[63:56];
    assign _87 = _85 == _121;
    assign _84 = _27[7:7];
    assign _88 = _84 & _87;
    assign _124 = { _88,
                    _93,
                    _98,
                    _103,
                    _108,
                    _113,
                    _118,
                    _123 };
    assign _125 = _124[7:7];
    assign _140 = _125 & _139;
    assign _153 = { _140,
                    _142,
                    _144,
                    _146,
                    _148,
                    _150,
                    _152,
                    _126 };
    assign _154 = _153[4:4];
    assign _156 = _154 | _155;
    assign _158 = _156 | _157;
    assign _160 = _158 | _159;
    assign _170 = { _160,
                    _165,
                    _169 };
    assign gnd = 1'b0;
    assign _171 = { gnd,
                    _170 };
    assign _173 = _171 + _172;
    assign _174 = _81 ? _173 : _639;
    always @* begin
        case (_174)
        0:
            _191 <= _671;
        1:
            _191 <= _230;
        2:
            _191 <= _177;
        3:
            _191 <= _178;
        4:
            _191 <= _179;
        5:
            _191 <= _180;
        6:
            _191 <= _181;
        7:
            _191 <= _182;
        8:
            _191 <= _659;
        9:
            _191 <= _659;
        10:
            _191 <= _659;
        11:
            _191 <= _659;
        12:
            _191 <= _659;
        13:
            _191 <= _659;
        14:
            _191 <= _659;
        default:
            _191 <= _659;
        endcase
    end
    assign _72 = 8'b11111101;
    assign _71 = _25[7:0];
    assign _73 = _71 == _72;
    assign _70 = _27[0:0];
    assign _74 = _70 & _73;
    assign _66 = _25[15:8];
    assign _68 = _66 == _72;
    assign _65 = _27[1:1];
    assign _69 = _65 & _68;
    assign _61 = _25[23:16];
    assign _63 = _61 == _72;
    assign _60 = _27[2:2];
    assign _64 = _60 & _63;
    assign _56 = _25[31:24];
    assign _58 = _56 == _72;
    assign _55 = _27[3:3];
    assign _59 = _55 & _58;
    assign _51 = _25[39:32];
    assign _53 = _51 == _72;
    assign _50 = _27[4:4];
    assign _54 = _50 & _53;
    assign _46 = _25[47:40];
    assign _48 = _46 == _72;
    assign _45 = _27[5:5];
    assign _49 = _45 & _48;
    assign _41 = _25[55:48];
    assign _43 = _41 == _72;
    assign _40 = _27[6:6];
    assign _44 = _40 & _43;
    assign _25 = xgmii_rxd;
    assign _36 = _25[63:56];
    assign _38 = _36 == _72;
    assign _27 = xgmii_rxc;
    assign _35 = _27[7:7];
    assign _39 = _35 & _38;
    assign _75 = { _39,
                   _44,
                   _49,
                   _54,
                   _59,
                   _64,
                   _69,
                   _74 };
    assign _192 = _75 & _191;
    assign _235 = _192 | _234;
    assign _237 = _235 | _236;
    assign _239 = _237 == _659;
    assign _240 = ~ _239;
    assign _289 = _240 ? _288 : _428;
    assign _347 = _289 < _346;
    assign _378 = _347 & _377;
    assign _383 = _378 & _382;
    assign _760 = _383 | _440;
    assign _761 = ~ _760;
    assign _762 = _398 & _761;
    assign _763 = _762 | _693;
    assign _765 = _763 & _764;
    assign _770 = _765 ? _348 : _769;
    assign _394 = 2'b11;
    assign _759 = _80 == _394;
    assign _771 = _759 ? _770 : _80;
    assign _350 = 2'b10;
    assign _758 = _80 == _350;
    assign _776 = _758 ? _775 : _771;
    assign _348 = 2'b01;
    assign _757 = _80 == _348;
    assign _780 = _757 ? _779 : _776;
    assign _756 = _80 == _78;
    assign _782 = _756 ? _781 : _780;
    assign _28 = _782;
    always @(posedge _20) begin
        if (_18)
            _80 <= _78;
        else
            _80 <= _28;
    end
    assign _81 = _78 == _80;
    assign _396 = _81 | _395;
    assign _397 = _396 & _390;
    assign _398 = _397 & _22;
    assign _752 = _398 | _693;
    assign _754 = _752 & _753;
    assign _784 = _754 & _783;
    assign _790 = _784 ? gnd : _789;
    assign _29 = _790;
    always @(posedge _20) begin
        if (_18)
            _474 <= _473;
        else
            _474 <= _29;
    end
    assign _510 = _474 ? _509 : _507;
    always @(posedge _20) begin
        if (_18)
            _513 <= _659;
        else
            _513 <= _510;
    end
    assign _514 = _513[7:7];
    assign _515 = { _624,
                    _514 };
    assign _519 = _515 + _518;
    assign _527 = _519 + _526;
    assign _543 = _527 + _542;
    assign _545 = _543 == _639;
    assign _546 = ~ _545;
    assign _792 = _546 & _791;
    assign _793 = _792 | _651;
    assign _795 = _793 & _794;
    assign rx_tvalid = _795;
    assign rx_tdata = _681;
    assign rx_tkeep = _672;
    assign rx_tstrb = _659;
    assign rx_tlast = _658;
    assign rx_tuser = _656;
    assign error_bad_fcs = _470;
    assign error_bad_frame = _466;
    assign error_runt = _462;
    assign error_oversize = _458;
    assign error_start_without_terminate = _454;

endmodule
