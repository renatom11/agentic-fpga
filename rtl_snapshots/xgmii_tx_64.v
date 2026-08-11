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

    wire _165;
    wire _49;
    wire _46;
    wire _43;
    wire _44;
    wire _45;
    wire _47;
    reg _51;
    wire _1;
    wire _163;
    wire _129;
    wire _131;
    wire _132;
    reg _135;
    wire _2;
    wire _160;
    wire _161;
    wire _162;
    wire _164;
    wire _166;
    wire [7:0] _472;
    wire [7:0] _469;
    wire [7:0] _467;
    wire _448;
    wire _463;
    wire _464;
    wire _411;
    wire _426;
    wire _427;
    wire _374;
    wire _389;
    wire _390;
    wire _337;
    wire _352;
    wire _353;
    wire _300;
    wire _315;
    wire _316;
    wire _263;
    wire _278;
    wire _279;
    wire _226;
    wire _241;
    wire _242;
    wire _189;
    wire _204;
    wire _205;
    wire [7:0] _465;
    wire [7:0] _466;
    wire [7:0] _468;
    wire [7:0] _470;
    reg [7:0] _473;
    wire [7:0] _474;
    wire [63:0] _714;
    wire [63:0] _711;
    wire [63:0] _709;
    wire [7:0] _705;
    wire [12:0] _699;
    wire [1:0] _700;
    reg [7:0] _701;
    wire [7:0] _697;
    wire [7:0] _696;
    wire [12:0] _694;
    wire _695;
    wire [7:0] _698;
    wire [11:0] _459;
    wire _457;
    wire _458;
    wire [12:0] _460;
    wire [12:0] _456;
    wire _461;
    wire [11:0] _452;
    wire _450;
    wire _451;
    wire [12:0] _453;
    wire _454;
    wire _455;
    wire _462;
    wire [7:0] _702;
    wire [11:0] _444;
    wire _442;
    wire _443;
    wire [12:0] _445;
    wire _446;
    wire [11:0] _437;
    wire _435;
    wire _436;
    wire [12:0] _438;
    wire _439;
    wire _440;
    wire _447;
    wire [7:0] _704;
    wire [11:0] _431;
    wire _429;
    wire _430;
    wire [12:0] _432;
    wire _433;
    wire [7:0] _706;
    wire [7:0] _692;
    wire [12:0] _686;
    wire [1:0] _687;
    reg [7:0] _688;
    wire [12:0] _681;
    wire _682;
    wire [7:0] _685;
    wire [11:0] _422;
    wire _420;
    wire _421;
    wire [12:0] _423;
    wire [12:0] _419;
    wire _424;
    wire [11:0] _415;
    wire _413;
    wire _414;
    wire [12:0] _416;
    wire _417;
    wire _418;
    wire _425;
    wire [7:0] _689;
    wire [11:0] _407;
    wire _405;
    wire _406;
    wire [12:0] _408;
    wire _409;
    wire [11:0] _400;
    wire _398;
    wire _399;
    wire [12:0] _401;
    wire _402;
    wire _403;
    wire _410;
    wire [7:0] _691;
    wire [11:0] _394;
    wire _392;
    wire _393;
    wire [12:0] _395;
    wire _396;
    wire [7:0] _693;
    wire [7:0] _679;
    wire [12:0] _673;
    wire [1:0] _674;
    reg [7:0] _675;
    wire [12:0] _668;
    wire _669;
    wire [7:0] _672;
    wire [11:0] _385;
    wire _383;
    wire _384;
    wire [12:0] _386;
    wire [12:0] _382;
    wire _387;
    wire [11:0] _378;
    wire _376;
    wire _377;
    wire [12:0] _379;
    wire _380;
    wire _381;
    wire _388;
    wire [7:0] _676;
    wire [11:0] _370;
    wire _368;
    wire _369;
    wire [12:0] _371;
    wire _372;
    wire [11:0] _363;
    wire _361;
    wire _362;
    wire [12:0] _364;
    wire _365;
    wire _366;
    wire _373;
    wire [7:0] _678;
    wire [11:0] _357;
    wire _355;
    wire _356;
    wire [12:0] _358;
    wire _359;
    wire [7:0] _680;
    wire [7:0] _666;
    wire [12:0] _660;
    wire [1:0] _661;
    reg [7:0] _662;
    wire [12:0] _655;
    wire _656;
    wire [7:0] _659;
    wire [11:0] _348;
    wire _346;
    wire _347;
    wire [12:0] _349;
    wire [12:0] _345;
    wire _350;
    wire [11:0] _341;
    wire _339;
    wire _340;
    wire [12:0] _342;
    wire _343;
    wire _344;
    wire _351;
    wire [7:0] _663;
    wire [11:0] _333;
    wire _331;
    wire _332;
    wire [12:0] _334;
    wire _335;
    wire [11:0] _326;
    wire _324;
    wire _325;
    wire [12:0] _327;
    wire _328;
    wire _329;
    wire _336;
    wire [7:0] _665;
    wire [11:0] _320;
    wire _318;
    wire _319;
    wire [12:0] _321;
    wire _322;
    wire [7:0] _667;
    wire [7:0] _653;
    wire [12:0] _647;
    wire [1:0] _648;
    reg [7:0] _649;
    wire [12:0] _642;
    wire _643;
    wire [7:0] _646;
    wire [11:0] _311;
    wire _309;
    wire _310;
    wire [12:0] _312;
    wire [12:0] _308;
    wire _313;
    wire [11:0] _304;
    wire _302;
    wire _303;
    wire [12:0] _305;
    wire _306;
    wire _307;
    wire _314;
    wire [7:0] _650;
    wire [11:0] _296;
    wire _294;
    wire _295;
    wire [12:0] _297;
    wire _298;
    wire [11:0] _289;
    wire _287;
    wire _288;
    wire [12:0] _290;
    wire _291;
    wire _292;
    wire _299;
    wire [7:0] _652;
    wire [11:0] _283;
    wire _281;
    wire _282;
    wire [12:0] _284;
    wire _285;
    wire [7:0] _654;
    wire [7:0] _640;
    wire [12:0] _634;
    wire [1:0] _635;
    reg [7:0] _636;
    wire [12:0] _629;
    wire _630;
    wire [7:0] _633;
    wire [11:0] _274;
    wire _272;
    wire _273;
    wire [12:0] _275;
    wire [12:0] _271;
    wire _276;
    wire [11:0] _267;
    wire _265;
    wire _266;
    wire [12:0] _268;
    wire _269;
    wire _270;
    wire _277;
    wire [7:0] _637;
    wire [11:0] _259;
    wire _257;
    wire _258;
    wire [12:0] _260;
    wire _261;
    wire [11:0] _252;
    wire _250;
    wire _251;
    wire [12:0] _253;
    wire _254;
    wire _255;
    wire _262;
    wire [7:0] _639;
    wire [11:0] _246;
    wire _244;
    wire _245;
    wire [12:0] _247;
    wire _248;
    wire [7:0] _641;
    wire [7:0] _627;
    wire [12:0] _621;
    wire [1:0] _622;
    reg [7:0] _623;
    wire [12:0] _616;
    wire _617;
    wire [7:0] _620;
    wire [11:0] _237;
    wire _235;
    wire _236;
    wire [12:0] _238;
    wire [12:0] _234;
    wire _239;
    wire [11:0] _230;
    wire _228;
    wire _229;
    wire [12:0] _231;
    wire _232;
    wire _233;
    wire _240;
    wire [7:0] _624;
    wire [11:0] _222;
    wire _220;
    wire _221;
    wire [12:0] _223;
    wire _224;
    wire [11:0] _215;
    wire _213;
    wire _214;
    wire [12:0] _216;
    wire _217;
    wire _218;
    wire _225;
    wire [7:0] _626;
    wire [11:0] _209;
    wire _207;
    wire _208;
    wire [12:0] _210;
    wire _211;
    wire [7:0] _628;
    wire [7:0] _614;
    wire [7:0] _609;
    wire [7:0] _608;
    wire [7:0] _607;
    wire _586;
    wire [1:0] _587;
    wire [3:0] _588;
    wire [7:0] _589;
    wire _582;
    wire [1:0] _583;
    wire [3:0] _584;
    wire [7:0] _585;
    wire _578;
    wire [1:0] _579;
    wire [3:0] _580;
    wire [7:0] _581;
    wire _574;
    wire [1:0] _575;
    wire [3:0] _576;
    wire [7:0] _577;
    wire _570;
    wire [1:0] _571;
    wire [3:0] _572;
    wire [7:0] _573;
    wire _566;
    wire [1:0] _567;
    wire [3:0] _568;
    wire [7:0] _569;
    wire _562;
    wire [1:0] _563;
    wire [3:0] _564;
    wire [7:0] _565;
    wire [7:0] _548;
    wire [7:0] _547;
    wire [7:0] _546;
    wire [7:0] _545;
    wire [7:0] _543;
    wire [3:0] _539;
    wire [3:0] _537;
    wire [3:0] _536;
    wire [12:0] _533;
    wire [11:0] _531;
    wire _529;
    wire _530;
    wire [12:0] _532;
    wire _534;
    wire _535;
    wire [3:0] _538;
    wire [11:0] _525;
    wire _523;
    wire _524;
    wire [12:0] _526;
    wire _527;
    wire _528;
    wire [3:0] _540;
    reg [7:0] _557;
    wire _558;
    wire [1:0] _559;
    wire [3:0] _560;
    wire [7:0] _561;
    wire [63:0] _590;
    wire _479;
    wire [63:0] _480;
    wire [1:0] _475;
    wire _476;
    wire _477;
    wire [63:0] _478;
    wire [63:0] _481;
    reg [63:0] _484;
    wire [63:0] _5;
    wire [63:0] _487;
    wire [63:0] _488;
    wire [63:0] _7;
    wire _485;
    wire [63:0] _486;
    wire [63:0] _489;
    reg [63:0] _492;
    wire [63:0] _8;
    wire [63:0] _591;
    wire [31:0] _520;
    wire [31:0] _516;
    wire [31:0] _518;
    reg [31:0] _521;
    wire [31:0] _9;
    wire [31:0] _593;
    wire [31:0] _10;
    reg [31:0] _597;
    wire [31:0] _11;
    wire [3:0] _507;
    wire [11:0] _502;
    wire _500;
    wire _501;
    wire [12:0] _503;
    wire _505;
    wire _506;
    wire [3:0] _509;
    wire [11:0] _496;
    wire _494;
    wire _495;
    wire [12:0] _497;
    wire _498;
    wire _499;
    wire [3:0] _511;
    wire _513;
    wire _514;
    wire _515;
    wire [31:0] _594;
    wire [7:0] _606;
    wire [12:0] _604;
    wire [1:0] _605;
    reg [7:0] _610;
    wire [12:0] _599;
    wire _600;
    wire [7:0] _603;
    wire [11:0] _200;
    wire _198;
    wire _199;
    wire [12:0] _201;
    wire [12:0] _197;
    wire _202;
    wire [11:0] _193;
    wire _191;
    wire _192;
    wire [12:0] _194;
    wire _195;
    wire _196;
    wire _203;
    wire [7:0] _611;
    wire [11:0] _185;
    wire _183;
    wire _184;
    wire [12:0] _186;
    wire _187;
    wire [11:0] _178;
    wire _176;
    wire _177;
    wire [12:0] _179;
    wire _180;
    wire _181;
    wire _188;
    wire [7:0] _613;
    wire [11:0] _172;
    wire [12:0] _169;
    wire _170;
    wire _171;
    wire [12:0] _173;
    wire _174;
    wire [7:0] _615;
    wire [63:0] _707;
    wire [63:0] _598;
    wire [63:0] _708;
    wire [63:0] _710;
    wire [63:0] _712;
    reg [63:0] _715;
    wire [63:0] _716;
    wire _157;
    wire _156;
    wire _158;
    wire _146;
    wire [1:0] _142;
    wire [1:0] _833;
    wire _825;
    wire _125;
    wire _124;
    wire _126;
    wire [1:0] _823;
    wire [1:0] _820;
    wire [1:0] _821;
    wire _810;
    wire _808;
    wire _14;
    wire _804;
    wire _805;
    wire [5:0] _152;
    wire [5:0] _798;
    wire [9:0] _793;
    wire [3:0] _790;
    wire [9:0] _791;
    wire [9:0] _788;
    wire [9:0] _792;
    wire [9:0] _794;
    wire [6:0] _795;
    wire [2:0] _786;
    wire [9:0] _796;
    wire [5:0] _797;
    wire [5:0] _799;
    wire [9:0] _776;
    wire [7:0] _16;
    wire [9:0] _775;
    wire [9:0] _777;
    wire [9:0] _779;
    wire [6:0] _780;
    wire [9:0] _781;
    wire [5:0] _782;
    wire [5:0] _784;
    wire [5:0] _771;
    wire [5:0] _772;
    wire _128;
    wire [5:0] _785;
    wire [11:0] _119;
    wire _117;
    wire _118;
    wire [12:0] _120;
    wire _121;
    wire _122;
    wire [11:0] _110;
    wire [12:0] _103;
    wire [12:0] _100;
    wire [11:0] _98;
    wire [12:0] _94;
    wire _88;
    wire [3:0] _89;
    wire _85;
    wire [3:0] _86;
    wire [3:0] _90;
    wire _81;
    wire [3:0] _82;
    wire _78;
    wire [3:0] _79;
    wire [3:0] _83;
    wire [3:0] _91;
    wire _73;
    wire [3:0] _74;
    wire _70;
    wire [3:0] _71;
    wire [3:0] _75;
    wire _66;
    wire [3:0] _67;
    wire _721;
    wire [7:0] _722;
    wire _718;
    wire _719;
    wire [7:0] _720;
    wire [7:0] _723;
    reg [7:0] _726;
    wire [7:0] _17;
    wire [7:0] _729;
    wire [7:0] _730;
    wire [7:0] _19;
    wire _727;
    wire [7:0] _728;
    wire [7:0] _731;
    reg [7:0] _734;
    wire [7:0] _20;
    wire _63;
    wire [3:0] _64;
    wire [3:0] _68;
    wire [3:0] _76;
    wire [3:0] _92;
    wire [8:0] _61;
    wire [12:0] _93;
    wire [12:0] _735;
    wire [12:0] _736;
    wire [12:0] _737;
    wire [12:0] _739;
    reg [12:0] _742;
    wire [12:0] _21;
    wire [12:0] _743;
    reg [12:0] _746;
    wire [12:0] _22;
    wire [12:0] _59;
    wire _747;
    wire _748;
    reg _751;
    wire _23;
    wire [12:0] _60;
    wire _756;
    wire _757;
    wire _753;
    wire _754;
    wire _755;
    wire _758;
    reg _761;
    wire _24;
    wire _764;
    wire _765;
    wire _26;
    wire _42;
    wire _762;
    wire _763;
    wire _766;
    reg _769;
    wire _27;
    wire _57;
    wire _58;
    wire [12:0] _95;
    wire _96;
    wire _97;
    wire [12:0] _99;
    wire _101;
    wire _102;
    wire [12:0] _104;
    wire [12:0] _105;
    wire [12:0] _107;
    wire _108;
    wire _109;
    wire [12:0] _111;
    wire _113;
    wire _114;
    wire _115;
    wire _123;
    wire [5:0] _800;
    reg [5:0] _803;
    wire [5:0] _28;
    wire _153;
    wire _151;
    wire _154;
    wire _149;
    wire _155;
    wire _806;
    wire _807;
    wire _809;
    wire _811;
    wire _29;
    wire [1:0] _817;
    wire [1:0] _150;
    wire _816;
    wire [1:0] _818;
    wire _815;
    wire [1:0] _819;
    wire _813;
    wire [1:0] _822;
    wire _812;
    wire [1:0] _824;
    wire [1:0] _30;
    reg [1:0] _55;
    wire _56;
    wire _127;
    wire _826;
    wire _31;
    wire [1:0] _830;
    wire _33;
    wire _827;
    wire _34;
    wire gnd;
    wire [1:0] _828;
    wire [1:0] _829;
    wire [1:0] _831;
    reg [1:0] _834;
    wire [1:0] _35;
    wire _143;
    wire _144;
    wire _37;
    wire vdd;
    reg _138;
    wire _139;
    wire _39;
    wire _140;
    wire _141;
    wire _145;
    wire _147;
    wire _159;
    assign _165 = ~ _39;
    assign _49 = 1'b0;
    assign _46 = _34 & _26;
    assign _43 = ~ _42;
    assign _44 = _43 & _27;
    assign _45 = _29 ? _44 : _1;
    assign _47 = _45 | _46;
    always @(posedge _37) begin
        if (_39)
            _51 <= _49;
        else
            _51 <= _47;
    end
    assign _1 = _51;
    assign _163 = ~ _1;
    assign _129 = _123 | _128;
    assign _131 = _129 ? gnd : _2;
    assign _132 = _29 ? vdd : _131;
    always @(posedge _37) begin
        if (_39)
            _135 <= _49;
        else
            _135 <= _132;
    end
    assign _2 = _135;
    assign _160 = ~ _33;
    assign _161 = _159 & _160;
    assign _162 = _161 & _2;
    assign _164 = _162 & _163;
    assign _166 = _164 & _165;
    assign _472 = 8'b00000000;
    assign _469 = 8'b00000001;
    assign _467 = 8'b11111111;
    assign _448 = _433 | _447;
    assign _463 = _448 | _462;
    assign _464 = ~ _463;
    assign _411 = _396 | _410;
    assign _426 = _411 | _425;
    assign _427 = ~ _426;
    assign _374 = _359 | _373;
    assign _389 = _374 | _388;
    assign _390 = ~ _389;
    assign _337 = _322 | _336;
    assign _352 = _337 | _351;
    assign _353 = ~ _352;
    assign _300 = _285 | _299;
    assign _315 = _300 | _314;
    assign _316 = ~ _315;
    assign _263 = _248 | _262;
    assign _278 = _263 | _277;
    assign _279 = ~ _278;
    assign _226 = _211 | _225;
    assign _241 = _226 | _240;
    assign _242 = ~ _241;
    assign _189 = _174 | _188;
    assign _204 = _189 | _203;
    assign _205 = ~ _204;
    assign _465 = { _205,
                    _242,
                    _279,
                    _316,
                    _353,
                    _390,
                    _427,
                    _464 };
    assign _466 = _56 ? _465 : _467;
    assign _468 = _128 ? _467 : _466;
    assign _470 = _29 ? _469 : _468;
    always @(posedge _37) begin
        if (_39)
            _473 <= _472;
        else
            _473 <= _470;
    end
    assign _474 = _140 ? _467 : _473;
    assign _714 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
    assign _711 = 64'b1101010101010101010101010101010101010101010101010101010111111011;
    assign _709 = 64'b0000011100000111000001110000011100000111000001111111110111111110;
    assign _705 = _8[7:0];
    assign _699 = _694 - _105;
    assign _700 = _699[1:0];
    always @* begin
        case (_700)
        0:
            _701 <= _606;
        1:
            _701 <= _607;
        2:
            _701 <= _608;
        default:
            _701 <= _609;
        endcase
    end
    assign _697 = 8'b11111101;
    assign _696 = 8'b00000111;
    assign _694 = 13'b0000000000000;
    assign _695 = _694 == _107;
    assign _698 = _695 ? _697 : _696;
    assign _459 = _107[11:0];
    assign _457 = _107[12:12];
    assign _458 = ~ _457;
    assign _460 = { _458,
                    _459 };
    assign _456 = 13'b1000000000000;
    assign _461 = _456 < _460;
    assign _452 = _105[11:0];
    assign _450 = _105[12:12];
    assign _451 = ~ _450;
    assign _453 = { _451,
                    _452 };
    assign _454 = _456 < _453;
    assign _455 = ~ _454;
    assign _462 = _455 & _461;
    assign _702 = _462 ? _701 : _698;
    assign _444 = _105[11:0];
    assign _442 = _105[12:12];
    assign _443 = ~ _442;
    assign _445 = { _443,
                    _444 };
    assign _446 = _456 < _445;
    assign _437 = _169[11:0];
    assign _435 = _169[12:12];
    assign _436 = ~ _435;
    assign _438 = { _436,
                    _437 };
    assign _439 = _456 < _438;
    assign _440 = ~ _439;
    assign _447 = _440 & _446;
    assign _704 = _447 ? _472 : _702;
    assign _431 = _169[11:0];
    assign _429 = _169[12:12];
    assign _430 = ~ _429;
    assign _432 = { _430,
                    _431 };
    assign _433 = _456 < _432;
    assign _706 = _433 ? _705 : _704;
    assign _692 = _8[15:8];
    assign _686 = _681 - _105;
    assign _687 = _686[1:0];
    always @* begin
        case (_687)
        0:
            _688 <= _606;
        1:
            _688 <= _607;
        2:
            _688 <= _608;
        default:
            _688 <= _609;
        endcase
    end
    assign _681 = 13'b0000000000001;
    assign _682 = _681 == _107;
    assign _685 = _682 ? _697 : _696;
    assign _422 = _107[11:0];
    assign _420 = _107[12:12];
    assign _421 = ~ _420;
    assign _423 = { _421,
                    _422 };
    assign _419 = 13'b1000000000001;
    assign _424 = _419 < _423;
    assign _415 = _105[11:0];
    assign _413 = _105[12:12];
    assign _414 = ~ _413;
    assign _416 = { _414,
                    _415 };
    assign _417 = _419 < _416;
    assign _418 = ~ _417;
    assign _425 = _418 & _424;
    assign _689 = _425 ? _688 : _685;
    assign _407 = _105[11:0];
    assign _405 = _105[12:12];
    assign _406 = ~ _405;
    assign _408 = { _406,
                    _407 };
    assign _409 = _419 < _408;
    assign _400 = _169[11:0];
    assign _398 = _169[12:12];
    assign _399 = ~ _398;
    assign _401 = { _399,
                    _400 };
    assign _402 = _419 < _401;
    assign _403 = ~ _402;
    assign _410 = _403 & _409;
    assign _691 = _410 ? _472 : _689;
    assign _394 = _169[11:0];
    assign _392 = _169[12:12];
    assign _393 = ~ _392;
    assign _395 = { _393,
                    _394 };
    assign _396 = _419 < _395;
    assign _693 = _396 ? _692 : _691;
    assign _679 = _8[23:16];
    assign _673 = _668 - _105;
    assign _674 = _673[1:0];
    always @* begin
        case (_674)
        0:
            _675 <= _606;
        1:
            _675 <= _607;
        2:
            _675 <= _608;
        default:
            _675 <= _609;
        endcase
    end
    assign _668 = 13'b0000000000010;
    assign _669 = _668 == _107;
    assign _672 = _669 ? _697 : _696;
    assign _385 = _107[11:0];
    assign _383 = _107[12:12];
    assign _384 = ~ _383;
    assign _386 = { _384,
                    _385 };
    assign _382 = 13'b1000000000010;
    assign _387 = _382 < _386;
    assign _378 = _105[11:0];
    assign _376 = _105[12:12];
    assign _377 = ~ _376;
    assign _379 = { _377,
                    _378 };
    assign _380 = _382 < _379;
    assign _381 = ~ _380;
    assign _388 = _381 & _387;
    assign _676 = _388 ? _675 : _672;
    assign _370 = _105[11:0];
    assign _368 = _105[12:12];
    assign _369 = ~ _368;
    assign _371 = { _369,
                    _370 };
    assign _372 = _382 < _371;
    assign _363 = _169[11:0];
    assign _361 = _169[12:12];
    assign _362 = ~ _361;
    assign _364 = { _362,
                    _363 };
    assign _365 = _382 < _364;
    assign _366 = ~ _365;
    assign _373 = _366 & _372;
    assign _678 = _373 ? _472 : _676;
    assign _357 = _169[11:0];
    assign _355 = _169[12:12];
    assign _356 = ~ _355;
    assign _358 = { _356,
                    _357 };
    assign _359 = _382 < _358;
    assign _680 = _359 ? _679 : _678;
    assign _666 = _8[31:24];
    assign _660 = _655 - _105;
    assign _661 = _660[1:0];
    always @* begin
        case (_661)
        0:
            _662 <= _606;
        1:
            _662 <= _607;
        2:
            _662 <= _608;
        default:
            _662 <= _609;
        endcase
    end
    assign _655 = 13'b0000000000011;
    assign _656 = _655 == _107;
    assign _659 = _656 ? _697 : _696;
    assign _348 = _107[11:0];
    assign _346 = _107[12:12];
    assign _347 = ~ _346;
    assign _349 = { _347,
                    _348 };
    assign _345 = 13'b1000000000011;
    assign _350 = _345 < _349;
    assign _341 = _105[11:0];
    assign _339 = _105[12:12];
    assign _340 = ~ _339;
    assign _342 = { _340,
                    _341 };
    assign _343 = _345 < _342;
    assign _344 = ~ _343;
    assign _351 = _344 & _350;
    assign _663 = _351 ? _662 : _659;
    assign _333 = _105[11:0];
    assign _331 = _105[12:12];
    assign _332 = ~ _331;
    assign _334 = { _332,
                    _333 };
    assign _335 = _345 < _334;
    assign _326 = _169[11:0];
    assign _324 = _169[12:12];
    assign _325 = ~ _324;
    assign _327 = { _325,
                    _326 };
    assign _328 = _345 < _327;
    assign _329 = ~ _328;
    assign _336 = _329 & _335;
    assign _665 = _336 ? _472 : _663;
    assign _320 = _169[11:0];
    assign _318 = _169[12:12];
    assign _319 = ~ _318;
    assign _321 = { _319,
                    _320 };
    assign _322 = _345 < _321;
    assign _667 = _322 ? _666 : _665;
    assign _653 = _8[39:32];
    assign _647 = _642 - _105;
    assign _648 = _647[1:0];
    always @* begin
        case (_648)
        0:
            _649 <= _606;
        1:
            _649 <= _607;
        2:
            _649 <= _608;
        default:
            _649 <= _609;
        endcase
    end
    assign _642 = 13'b0000000000100;
    assign _643 = _642 == _107;
    assign _646 = _643 ? _697 : _696;
    assign _311 = _107[11:0];
    assign _309 = _107[12:12];
    assign _310 = ~ _309;
    assign _312 = { _310,
                    _311 };
    assign _308 = 13'b1000000000100;
    assign _313 = _308 < _312;
    assign _304 = _105[11:0];
    assign _302 = _105[12:12];
    assign _303 = ~ _302;
    assign _305 = { _303,
                    _304 };
    assign _306 = _308 < _305;
    assign _307 = ~ _306;
    assign _314 = _307 & _313;
    assign _650 = _314 ? _649 : _646;
    assign _296 = _105[11:0];
    assign _294 = _105[12:12];
    assign _295 = ~ _294;
    assign _297 = { _295,
                    _296 };
    assign _298 = _308 < _297;
    assign _289 = _169[11:0];
    assign _287 = _169[12:12];
    assign _288 = ~ _287;
    assign _290 = { _288,
                    _289 };
    assign _291 = _308 < _290;
    assign _292 = ~ _291;
    assign _299 = _292 & _298;
    assign _652 = _299 ? _472 : _650;
    assign _283 = _169[11:0];
    assign _281 = _169[12:12];
    assign _282 = ~ _281;
    assign _284 = { _282,
                    _283 };
    assign _285 = _308 < _284;
    assign _654 = _285 ? _653 : _652;
    assign _640 = _8[47:40];
    assign _634 = _629 - _105;
    assign _635 = _634[1:0];
    always @* begin
        case (_635)
        0:
            _636 <= _606;
        1:
            _636 <= _607;
        2:
            _636 <= _608;
        default:
            _636 <= _609;
        endcase
    end
    assign _629 = 13'b0000000000101;
    assign _630 = _629 == _107;
    assign _633 = _630 ? _697 : _696;
    assign _274 = _107[11:0];
    assign _272 = _107[12:12];
    assign _273 = ~ _272;
    assign _275 = { _273,
                    _274 };
    assign _271 = 13'b1000000000101;
    assign _276 = _271 < _275;
    assign _267 = _105[11:0];
    assign _265 = _105[12:12];
    assign _266 = ~ _265;
    assign _268 = { _266,
                    _267 };
    assign _269 = _271 < _268;
    assign _270 = ~ _269;
    assign _277 = _270 & _276;
    assign _637 = _277 ? _636 : _633;
    assign _259 = _105[11:0];
    assign _257 = _105[12:12];
    assign _258 = ~ _257;
    assign _260 = { _258,
                    _259 };
    assign _261 = _271 < _260;
    assign _252 = _169[11:0];
    assign _250 = _169[12:12];
    assign _251 = ~ _250;
    assign _253 = { _251,
                    _252 };
    assign _254 = _271 < _253;
    assign _255 = ~ _254;
    assign _262 = _255 & _261;
    assign _639 = _262 ? _472 : _637;
    assign _246 = _169[11:0];
    assign _244 = _169[12:12];
    assign _245 = ~ _244;
    assign _247 = { _245,
                    _246 };
    assign _248 = _271 < _247;
    assign _641 = _248 ? _640 : _639;
    assign _627 = _8[55:48];
    assign _621 = _616 - _105;
    assign _622 = _621[1:0];
    always @* begin
        case (_622)
        0:
            _623 <= _606;
        1:
            _623 <= _607;
        2:
            _623 <= _608;
        default:
            _623 <= _609;
        endcase
    end
    assign _616 = 13'b0000000000110;
    assign _617 = _616 == _107;
    assign _620 = _617 ? _697 : _696;
    assign _237 = _107[11:0];
    assign _235 = _107[12:12];
    assign _236 = ~ _235;
    assign _238 = { _236,
                    _237 };
    assign _234 = 13'b1000000000110;
    assign _239 = _234 < _238;
    assign _230 = _105[11:0];
    assign _228 = _105[12:12];
    assign _229 = ~ _228;
    assign _231 = { _229,
                    _230 };
    assign _232 = _234 < _231;
    assign _233 = ~ _232;
    assign _240 = _233 & _239;
    assign _624 = _240 ? _623 : _620;
    assign _222 = _105[11:0];
    assign _220 = _105[12:12];
    assign _221 = ~ _220;
    assign _223 = { _221,
                    _222 };
    assign _224 = _234 < _223;
    assign _215 = _169[11:0];
    assign _213 = _169[12:12];
    assign _214 = ~ _213;
    assign _216 = { _214,
                    _215 };
    assign _217 = _234 < _216;
    assign _218 = ~ _217;
    assign _225 = _218 & _224;
    assign _626 = _225 ? _472 : _624;
    assign _209 = _169[11:0];
    assign _207 = _169[12:12];
    assign _208 = ~ _207;
    assign _210 = { _208,
                    _209 };
    assign _211 = _234 < _210;
    assign _628 = _211 ? _627 : _626;
    assign _614 = _8[63:56];
    assign _609 = _594[31:24];
    assign _608 = _594[23:16];
    assign _607 = _594[15:8];
    assign _586 = _557[0:0];
    assign _587 = { _586,
                    _586 };
    assign _588 = { _587,
                    _587 };
    assign _589 = { _588,
                    _588 };
    assign _582 = _557[1:1];
    assign _583 = { _582,
                    _582 };
    assign _584 = { _583,
                    _583 };
    assign _585 = { _584,
                    _584 };
    assign _578 = _557[2:2];
    assign _579 = { _578,
                    _578 };
    assign _580 = { _579,
                    _579 };
    assign _581 = { _580,
                    _580 };
    assign _574 = _557[3:3];
    assign _575 = { _574,
                    _574 };
    assign _576 = { _575,
                    _575 };
    assign _577 = { _576,
                    _576 };
    assign _570 = _557[4:4];
    assign _571 = { _570,
                    _570 };
    assign _572 = { _571,
                    _571 };
    assign _573 = { _572,
                    _572 };
    assign _566 = _557[5:5];
    assign _567 = { _566,
                    _566 };
    assign _568 = { _567,
                    _567 };
    assign _569 = { _568,
                    _568 };
    assign _562 = _557[6:6];
    assign _563 = { _562,
                    _562 };
    assign _564 = { _563,
                    _563 };
    assign _565 = { _564,
                    _564 };
    assign _548 = 8'b01111111;
    assign _547 = 8'b00111111;
    assign _546 = 8'b00011111;
    assign _545 = 8'b00001111;
    assign _543 = 8'b00000011;
    assign _539 = 4'b0000;
    assign _537 = 4'b1000;
    assign _536 = _169[3:0];
    assign _533 = 13'b1000000001000;
    assign _531 = _169[11:0];
    assign _529 = _169[12:12];
    assign _530 = ~ _529;
    assign _532 = { _530,
                    _531 };
    assign _534 = _532 < _533;
    assign _535 = ~ _534;
    assign _538 = _535 ? _537 : _536;
    assign _525 = _169[11:0];
    assign _523 = _169[12:12];
    assign _524 = ~ _523;
    assign _526 = { _524,
                    _525 };
    assign _527 = _456 < _526;
    assign _528 = ~ _527;
    assign _540 = _528 ? _539 : _538;
    always @* begin
        case (_540)
        0:
            _557 <= _472;
        1:
            _557 <= _469;
        2:
            _557 <= _543;
        3:
            _557 <= _696;
        4:
            _557 <= _545;
        5:
            _557 <= _546;
        6:
            _557 <= _547;
        7:
            _557 <= _548;
        8:
            _557 <= _467;
        9:
            _557 <= _467;
        10:
            _557 <= _467;
        11:
            _557 <= _467;
        12:
            _557 <= _467;
        13:
            _557 <= _467;
        14:
            _557 <= _467;
        default:
            _557 <= _467;
        endcase
    end
    assign _558 = _557[7:7];
    assign _559 = { _558,
                    _558 };
    assign _560 = { _559,
                    _559 };
    assign _561 = { _560,
                    _560 };
    assign _590 = { _561,
                    _565,
                    _569,
                    _573,
                    _577,
                    _581,
                    _585,
                    _589 };
    assign _479 = _143 & _34;
    assign _480 = _479 ? _7 : _5;
    assign _475 = 2'b01;
    assign _476 = _35 == _475;
    assign _477 = _476 & _34;
    assign _478 = _477 ? _7 : _5;
    assign _481 = _31 ? _480 : _478;
    always @(posedge _37) begin
        if (_39)
            _484 <= _714;
        else
            _484 <= _481;
    end
    assign _5 = _484;
    assign _487 = _34 ? _7 : _8;
    assign _488 = _143 ? _5 : _487;
    assign _7 = tx_tdata;
    assign _485 = _42 & _34;
    assign _486 = _485 ? _7 : _8;
    assign _489 = _31 ? _488 : _486;
    always @(posedge _37) begin
        if (_39)
            _492 <= _714;
        else
            _492 <= _489;
    end
    assign _8 = _492;
    assign _591 = _8 & _590;
    assign _520 = 32'b00000000000000000000000000000000;
    assign _516 = _515 ? _10 : _9;
    assign _518 = _29 ? _520 : _516;
    always @(posedge _37) begin
        if (_39)
            _521 <= _520;
        else
            _521 <= _518;
    end
    assign _9 = _521;
    crc32_eth
        crc32_eth
        ( .crc_in(_9),
          .data(_591),
          .octet_count(_511),
          .crc_out(_593[31:0]) );
    assign _10 = _593;
    always @(posedge _37) begin
        if (_39)
            _597 <= _520;
        else
            _597 <= _594;
    end
    assign _11 = _597;
    assign _507 = _105[3:0];
    assign _502 = _105[11:0];
    assign _500 = _105[12:12];
    assign _501 = ~ _500;
    assign _503 = { _501,
                    _502 };
    assign _505 = _503 < _533;
    assign _506 = ~ _505;
    assign _509 = _506 ? _537 : _507;
    assign _496 = _105[11:0];
    assign _494 = _105[12:12];
    assign _495 = ~ _494;
    assign _497 = { _495,
                    _496 };
    assign _498 = _456 < _497;
    assign _499 = ~ _498;
    assign _511 = _499 ? _539 : _509;
    assign _513 = _511 == _539;
    assign _514 = ~ _513;
    assign _515 = _56 & _514;
    assign _594 = _515 ? _10 : _11;
    assign _606 = _594[7:0];
    assign _604 = _599 - _105;
    assign _605 = _604[1:0];
    always @* begin
        case (_605)
        0:
            _610 <= _606;
        1:
            _610 <= _607;
        2:
            _610 <= _608;
        default:
            _610 <= _609;
        endcase
    end
    assign _599 = 13'b0000000000111;
    assign _600 = _599 == _107;
    assign _603 = _600 ? _697 : _696;
    assign _200 = _107[11:0];
    assign _198 = _107[12:12];
    assign _199 = ~ _198;
    assign _201 = { _199,
                    _200 };
    assign _197 = 13'b1000000000111;
    assign _202 = _197 < _201;
    assign _193 = _105[11:0];
    assign _191 = _105[12:12];
    assign _192 = ~ _191;
    assign _194 = { _192,
                    _193 };
    assign _195 = _197 < _194;
    assign _196 = ~ _195;
    assign _203 = _196 & _202;
    assign _611 = _203 ? _610 : _603;
    assign _185 = _105[11:0];
    assign _183 = _105[12:12];
    assign _184 = ~ _183;
    assign _186 = { _184,
                    _185 };
    assign _187 = _197 < _186;
    assign _178 = _169[11:0];
    assign _176 = _169[12:12];
    assign _177 = ~ _176;
    assign _179 = { _177,
                    _178 };
    assign _180 = _197 < _179;
    assign _181 = ~ _180;
    assign _188 = _181 & _187;
    assign _613 = _188 ? _472 : _611;
    assign _172 = _169[11:0];
    assign _169 = _95 - _21;
    assign _170 = _169[12:12];
    assign _171 = ~ _170;
    assign _173 = { _171,
                    _172 };
    assign _174 = _197 < _173;
    assign _615 = _174 ? _614 : _613;
    assign _707 = { _615,
                    _628,
                    _641,
                    _654,
                    _667,
                    _680,
                    _693,
                    _706 };
    assign _598 = 64'b0000011100000111000001110000011100000111000001110000011100000111;
    assign _708 = _56 ? _707 : _598;
    assign _710 = _128 ? _709 : _708;
    assign _712 = _29 ? _711 : _710;
    always @(posedge _37) begin
        if (_39)
            _715 <= _714;
        else
            _715 <= _712;
    end
    assign _716 = _140 ? _598 : _715;
    assign _157 = _56 & _127;
    assign _156 = _155 & _14;
    assign _158 = _156 | _157;
    assign _146 = ~ _128;
    assign _142 = 2'b10;
    assign _833 = 2'b00;
    assign _825 = ~ _42;
    assign _125 = _21 < _22;
    assign _124 = ~ _23;
    assign _126 = _124 | _125;
    assign _823 = _29 ? _475 : _55;
    assign _820 = _123 ? _150 : _55;
    assign _821 = _128 ? _142 : _820;
    assign _810 = ~ _39;
    assign _808 = ~ _140;
    assign _14 = cfg_tx_enable;
    assign _804 = ~ _42;
    assign _805 = _804 | _34;
    assign _152 = 6'b000000;
    assign _798 = 6'b000001;
    assign _793 = 10'b0000000111;
    assign _790 = _107[3:0];
    assign _791 = { _152,
                    _790 };
    assign _788 = { _833,
                    _16 };
    assign _792 = _788 + _791;
    assign _794 = _792 + _793;
    assign _795 = _794[9:3];
    assign _786 = 3'b000;
    assign _796 = { _786,
                    _795 };
    assign _797 = _796[5:0];
    assign _799 = _797 - _798;
    assign _776 = 10'b0000000001;
    assign _16 = cfg_ifg;
    assign _775 = { _833,
                    _16 };
    assign _777 = _775 + _776;
    assign _779 = _777 + _793;
    assign _780 = _779[9:3];
    assign _781 = { _786,
                    _780 };
    assign _782 = _781[5:0];
    assign _784 = _782 - _798;
    assign _771 = _28 - _798;
    assign _772 = _153 ? _28 : _771;
    assign _128 = _127 & _42;
    assign _785 = _128 ? _784 : _772;
    assign _119 = _107[11:0];
    assign _117 = _107[12:12];
    assign _118 = ~ _117;
    assign _120 = { _118,
                    _119 };
    assign _121 = _197 < _120;
    assign _122 = ~ _121;
    assign _110 = _107[11:0];
    assign _103 = 13'b0000000111100;
    assign _100 = 13'b1000000111100;
    assign _98 = _95[11:0];
    assign _94 = _21 + _93;
    assign _88 = _20[0:0];
    assign _89 = { _786,
                   _88 };
    assign _85 = _20[1:1];
    assign _86 = { _786,
                   _85 };
    assign _90 = _86 + _89;
    assign _81 = _20[2:2];
    assign _82 = { _786,
                   _81 };
    assign _78 = _20[3:3];
    assign _79 = { _786,
                   _78 };
    assign _83 = _79 + _82;
    assign _91 = _83 + _90;
    assign _73 = _20[4:4];
    assign _74 = { _786,
                   _73 };
    assign _70 = _20[5:5];
    assign _71 = { _786,
                   _70 };
    assign _75 = _71 + _74;
    assign _66 = _20[6:6];
    assign _67 = { _786,
                   _66 };
    assign _721 = _143 & _34;
    assign _722 = _721 ? _19 : _17;
    assign _718 = _35 == _475;
    assign _719 = _718 & _34;
    assign _720 = _719 ? _19 : _17;
    assign _723 = _31 ? _722 : _720;
    always @(posedge _37) begin
        if (_39)
            _726 <= _472;
        else
            _726 <= _723;
    end
    assign _17 = _726;
    assign _729 = _34 ? _19 : _20;
    assign _730 = _143 ? _17 : _729;
    assign _19 = tx_tkeep;
    assign _727 = _42 & _34;
    assign _728 = _727 ? _19 : _20;
    assign _731 = _31 ? _730 : _728;
    always @(posedge _37) begin
        if (_39)
            _734 <= _472;
        else
            _734 <= _731;
    end
    assign _20 = _734;
    assign _63 = _20[7:7];
    assign _64 = { _786,
                   _63 };
    assign _68 = _64 + _67;
    assign _76 = _68 + _75;
    assign _92 = _76 + _91;
    assign _61 = 9'b000000000;
    assign _93 = { _61,
                   _92 };
    assign _735 = 13'b0000000001000;
    assign _736 = _21 + _735;
    assign _737 = _56 ? _736 : _21;
    assign _739 = _29 ? _694 : _737;
    always @(posedge _37) begin
        if (_39)
            _742 <= _694;
        else
            _742 <= _739;
    end
    assign _21 = _742;
    assign _743 = _21 + _93;
    always @(posedge _37) begin
        if (_39)
            _746 <= _694;
        else
            if (_58)
                _746 <= _743;
    end
    assign _22 = _746;
    assign _59 = 13'b0111110100000;
    assign _747 = _23 | _58;
    assign _748 = _29 ? gnd : _747;
    always @(posedge _37) begin
        if (_39)
            _751 <= _49;
        else
            _751 <= _748;
    end
    assign _23 = _751;
    assign _60 = _23 ? _22 : _59;
    assign _756 = _143 & _34;
    assign _757 = _756 ? _26 : _24;
    assign _753 = _35 == _475;
    assign _754 = _753 & _34;
    assign _755 = _754 ? _26 : _24;
    assign _758 = _31 ? _757 : _755;
    always @(posedge _37) begin
        if (_39)
            _761 <= _49;
        else
            _761 <= _758;
    end
    assign _24 = _761;
    assign _764 = _34 ? _26 : _27;
    assign _765 = _143 ? _24 : _764;
    assign _26 = tx_tlast;
    assign _42 = _35 == _833;
    assign _762 = _42 & _34;
    assign _763 = _762 ? _26 : _27;
    assign _766 = _31 ? _765 : _763;
    always @(posedge _37) begin
        if (_39)
            _769 <= _49;
        else
            _769 <= _766;
    end
    assign _27 = _769;
    assign _57 = _56 & _31;
    assign _58 = _57 & _27;
    assign _95 = _58 ? _94 : _60;
    assign _96 = _95[12:12];
    assign _97 = ~ _96;
    assign _99 = { _97,
                   _98 };
    assign _101 = _99 < _100;
    assign _102 = ~ _101;
    assign _104 = _102 ? _95 : _103;
    assign _105 = _104 - _21;
    assign _107 = _105 + _642;
    assign _108 = _107[12:12];
    assign _109 = ~ _108;
    assign _111 = { _109,
                    _110 };
    assign _113 = _111 < _456;
    assign _114 = ~ _113;
    assign _115 = _56 & _114;
    assign _123 = _115 & _122;
    assign _800 = _123 ? _799 : _785;
    always @(posedge _37) begin
        if (_39)
            _803 <= _152;
        else
            _803 <= _800;
    end
    assign _28 = _803;
    assign _153 = _28 == _152;
    assign _151 = _150 == _55;
    assign _154 = _151 & _153;
    assign _149 = _833 == _55;
    assign _155 = _149 | _154;
    assign _806 = _155 & _805;
    assign _807 = _806 & _14;
    assign _809 = _807 & _808;
    assign _811 = _809 & _810;
    assign _29 = _811;
    assign _817 = _29 ? _475 : _55;
    assign _150 = 2'b11;
    assign _816 = _55 == _150;
    assign _818 = _816 ? _817 : _55;
    assign _815 = _55 == _142;
    assign _819 = _815 ? _150 : _818;
    assign _813 = _55 == _475;
    assign _822 = _813 ? _821 : _819;
    assign _812 = _55 == _833;
    assign _824 = _812 ? _823 : _822;
    assign _30 = _824;
    always @(posedge _37) begin
        if (_39)
            _55 <= _833;
        else
            _55 <= _30;
    end
    assign _56 = _475 == _55;
    assign _127 = _56 & _126;
    assign _826 = _127 & _825;
    assign _31 = _826;
    assign _830 = { gnd,
                    _31 };
    assign _33 = tx_tvalid;
    assign _827 = _159 & _33;
    assign _34 = _827;
    assign gnd = 1'b0;
    assign _828 = { gnd,
                    _34 };
    assign _829 = _35 + _828;
    assign _831 = _829 - _830;
    always @(posedge _37) begin
        if (_39)
            _834 <= _833;
        else
            _834 <= _831;
    end
    assign _35 = _834;
    assign _143 = _35 == _142;
    assign _144 = ~ _143;
    assign _37 = clock;
    assign vdd = 1'b1;
    always @(posedge _37) begin
        if (_39)
            _138 <= _49;
        else
            _138 <= vdd;
    end
    assign _139 = ~ _138;
    assign _39 = clear;
    assign _140 = _39 | _139;
    assign _141 = ~ _140;
    assign _145 = _141 & _144;
    assign _147 = _145 & _146;
    assign _159 = _147 & _158;
    assign tx_tready = _159;
    assign xgmii_txd = _716;
    assign xgmii_txc = _474;
    assign error_underflow = _166;

endmodule
