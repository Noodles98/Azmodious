#include "registry.as"

namespace TeamMapProfileImported {

void RegisterAll()
{
	array<TeamMapProfileTypes::StartSpot> acidic_quarrySpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 1200), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1200, 0, 4800), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5100, 0, 1200), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5000, 0, 4800), "air", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("AcidicQuarry", acidic_quarrySpots));

	array<TeamMapProfileTypes::StartSpot> all_that_glittersSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(668, 0, 755), "air", false),  // P1
		TeamMapProfileTypes::StartSpot(AIFloat3(2801, 0, 775), "front", false),  // P2
		TeamMapProfileTypes::StartSpot(AIFloat3(4211, 0, 609), "tech", false),  // P3
		TeamMapProfileTypes::StartSpot(AIFloat3(5762, 0, 600), "air", false),  // P4
		TeamMapProfileTypes::StartSpot(AIFloat3(1159, 0, 1943), "front", false),  // P5
		TeamMapProfileTypes::StartSpot(AIFloat3(3061, 0, 1967), "tech", false),  // P6
		TeamMapProfileTypes::StartSpot(AIFloat3(4298, 0, 1996), "front", false),  // P7
		TeamMapProfileTypes::StartSpot(AIFloat3(5472, 0, 2030), "front", false),  // P8
		TeamMapProfileTypes::StartSpot(AIFloat3(5475, 0, 9444), "front", false),  // P9
		TeamMapProfileTypes::StartSpot(AIFloat3(3452, 0, 9689), "front", false),  // P10
		TeamMapProfileTypes::StartSpot(AIFloat3(1943, 0, 9622), "tech", false),  // P11
		TeamMapProfileTypes::StartSpot(AIFloat3(408, 0, 9640), "air", false),  // P12
		TeamMapProfileTypes::StartSpot(AIFloat3(5166, 0, 8246), "front", false),  // P13
		TeamMapProfileTypes::StartSpot(AIFloat3(3212, 0, 8249), "tech", false),  // P14
		TeamMapProfileTypes::StartSpot(AIFloat3(1859, 0, 8256), "front", false),  // P15
		TeamMapProfileTypes::StartSpot(AIFloat3(697, 0, 8224), "front", false),  // P16
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("All That Glitters", all_that_glittersSpots));

	array<TeamMapProfileTypes::StartSpot> ancient_bastion_remakeSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(4000, 0, 1500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2600, 0, 2800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(450, 0, 4100), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 4000), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 4000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(900, 0, 5100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 5400), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 6600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 4300), "air", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Ancient Bastion Remake", ancient_bastion_remakeSpots));

	array<TeamMapProfileTypes::StartSpot> eight_horsesSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(795, 0, 211), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(683, 0, 2016), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(320, 0, 3580), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(331, 0, 5162), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(671, 0, 6122), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(905, 0, 7170), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(718, 0, 8383), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(970, 0, 9829), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11492, 0, 226), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11598, 0, 2013), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11883, 0, 3555), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11934, 0, 5164), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11619, 0, 6116), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11380, 0, 7138), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11541, 0, 8370), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11289, 0, 9831), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Eight Horses", eight_horsesSpots));

	array<TeamMapProfileTypes::StartSpot> flats_and_forestsSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(631, 0, 364), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2052, 0, 1495), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(677, 0, 3458), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2080, 0, 4490), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2057, 0, 7456), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(696, 0, 8851), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2058, 0, 10751), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(668, 0, 11601), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11630, 0, 11899), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10175, 0, 10706), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11570, 0, 8810), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10147, 0, 7687), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10114, 0, 4459), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11562, 0, 3471), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10191, 0, 1565), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11627, 0, 681), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Flats and Forests", flats_and_forestsSpots));

	array<TeamMapProfileTypes::StartSpot> forgeSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 1600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(430, 0, 3500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 4000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 5200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 6150), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2030, 0, 7600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 7700), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 8400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7000, 0, 1600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8700, 0, 2000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 3500), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 4100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 5200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 6100), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7100, 0, 7600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7200, 0, 8400), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Forge", forgeSpots));

	array<TeamMapProfileTypes::StartSpot> glacial_gapSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(490, 0, 1140), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1800, 0, 1400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(430, 0, 2300), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1800, 0, 2550), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1430, 0, 4000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(700, 0, 4600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 5800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(880, 0, 6850), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12572, 0, 1400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14000, 0, 1100), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12640, 0, 2500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13890, 0, 2246), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12925, 0, 4000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13700, 0, 4600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12618, 0, 5800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13454, 0, 6850), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Glacial Gap", glacial_gapSpots));

	array<TeamMapProfileTypes::StartSpot> koom_valleySpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(410, 0, 730), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 2400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1400, 0, 4100), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(300, 0, 2800), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 4000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 6000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2050, 0, 7500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10600, 0, 730), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10300, 0, 2400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 4100), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 5600), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9000, 0, 4000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 6000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10400, 0, 7500), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Koom Valley", koom_valleySpots));

	array<TeamMapProfileTypes::StartSpot> mediterraneumSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(1300, 0, 1200), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 2800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5600, 0, 1500), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7800, 0, 2500), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(750, 0, 3800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(15600, 0, 700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4800, 0, 6200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7800, 0, 5100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10800, 0, 3600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14600, 0, 4500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1180, 0, 7100), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 7100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14800, 0, 6400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(15700, 0, 6900), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 11000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(6800, 0, 11000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10400, 0, 11400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14000, 0, 11600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1040, 0, 10100), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 12700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 14200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10600, 0, 11600), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13200, 0, 13000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 13200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4500, 0, 15500), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 15800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(15200, 0, 15500), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Mediterraneum_V1", mediterraneumSpots));

	array<TeamMapProfileTypes::StartSpot> raptor_craterSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(10200, 0, 400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 3000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 3000), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11700, 0, 5200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11800, 0, 7100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11900, 0, 9000), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10700, 0, 9600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 11900), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Raptor_Crater", raptor_craterSpots));

	array<TeamMapProfileTypes::StartSpot> red_river_estuarySpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 900), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2100, 0, 2300), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 4000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(500, 0, 5200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1900, 0, 7200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(300, 0, 7800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1800, 0, 9100), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 9700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8060, 0, 900), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 2300), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9500, 0, 4500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 5000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8300, 0, 6700), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 7100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8300, 0, 9200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9800, 0, 9700), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Red River Estuary", red_river_estuarySpots));

	array<TeamMapProfileTypes::StartSpot> serene_calderaSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 2900), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4500, 0, 1600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(6600, 0, 1000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 2900), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 1100), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 3200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 1600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12800, 0, 2700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 12600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4500, 0, 13800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(6600, 0, 14250), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 13000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8800, 0, 14300), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10100, 0, 13000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11000, 0, 14200), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12800, 0, 12500), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Serene Caldera", serene_calderaSpots));

	array<TeamMapProfileTypes::StartSpot> shore_to_shoreSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(560, 0, 730), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(550, 0, 1740), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(340, 0, 2700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 730), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 1740), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 2700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14800, 0, 550), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14800, 0, 1450), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(14800, 0, 2300), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13250, 0, 730), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13250, 0, 1740), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(13250, 0, 2700), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Shore_to_Shore_V3", shore_to_shoreSpots));

	array<TeamMapProfileTypes::StartSpot> sinkhole_networkSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 2300), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 2200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8400, 0, 3700), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 3600), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 5000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 6400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9300, 0, 6300), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8000, 0, 7800), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Sinkhole Network", sinkhole_networkSpots));

	array<TeamMapProfileTypes::StartSpot> supreme_isthmusSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(711, 0, 7218), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(837, 0, 10407), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2155, 0, 11747), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2513, 0, 7983), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4595, 0, 7440), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4997, 0, 8570), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4375, 0, 9800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4814, 0, 11077), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11579, 0, 5063), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11456, 0, 1901), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10129, 0, 541), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9764, 0, 4339), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7729, 0, 4835), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7292, 0, 3727), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7925, 0, 2500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7492, 0, 1220), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Supreme Isthmus", supreme_isthmusSpots));

	array<TeamMapProfileTypes::StartSpot> swirly_rockSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(3200, 0, 550), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(900, 0, 2700), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2200, 0, 3300), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(400, 0, 4500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2000, 0, 4700), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1800, 0, 6200), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(3000, 0, 6100), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 550), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9100, 0, 3500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 3500), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(11500, 0, 3000), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10300, 0, 4800), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(12000, 0, 4800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10000, 0, 6000), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(10500, 0, 6200), "front", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Swirly Rock", swirly_rockSpots));

	array<TeamMapProfileTypes::StartSpot> tempestSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 600), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 400), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5700, 0, 400), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 400), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 1700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 1700), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 2600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5700, 0, 2600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(600, 0, 9800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 9800), "tech", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5700, 0, 9800), "air", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9600, 0, 9800), "front", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 8600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5800, 0, 8600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4200, 0, 7600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5700, 0, 7600), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tempest", tempestSpots));

	array<TeamMapProfileTypes::StartSpot> tundra_continentsSpots = {
		TeamMapProfileTypes::StartSpot(AIFloat3(300, 0, 460), "sea", true),
		TeamMapProfileTypes::StartSpot(AIFloat3(1700, 0, 2300), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 800), "tech", true),
		TeamMapProfileTypes::StartSpot(AIFloat3(4100, 0, 2100), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(5400, 0, 800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(6400, 0, 800), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(7800, 0, 1500), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9200, 0, 1500), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1504, 0, 12000), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(1610, 0, 10300), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(2800, 0, 11400), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(4600, 0, 11400), "air", true),
		TeamMapProfileTypes::StartSpot(AIFloat3(6000, 0, 11400), "tech", true),
		TeamMapProfileTypes::StartSpot(AIFloat3(6700, 0, 10600), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(8200, 0, 10900), "sea", false),
		TeamMapProfileTypes::StartSpot(AIFloat3(9000, 0, 11400), "sea", false),
	};
	TeamMapProfileRegistry::Register(TeamMapProfileTypes::Profile("Tundra Continents", tundra_continentsSpots));

}

}  // namespace TeamMapProfileImported

