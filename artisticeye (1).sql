-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 16. 10:07
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `artisticeye`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cimkek`
--

CREATE TABLE `cimkek` (
  `id` int(11) NOT NULL,
  `nev` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `id` int(11) NOT NULL,
  `fnev` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `jelszo` varchar(255) NOT NULL,
  `bio` text DEFAULT NULL,
  `pkep_url` varchar(500) DEFAULT NULL,
  `keszul` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `fnev`, `email`, `jelszo`, `bio`, `pkep_url`, `keszul`) VALUES
(1, 'kissjanos93', 'kiss.janos93@email.hu', '$2y$10$AbCdEfGhIjKlMnOpQrStUv', 'Szoftverfejlesztő vagyok, szeretem a természetfotózást és a kerékpártúrákat.', 'https://example.com/kepek/profil1.jpg', '2026-01-12 17:42:36'),
(2, 'anna88', 'anna.kovacs@example.com', '$2y$10$XyZaBcDeFgHiJkLmNoPqRsT', NULL, NULL, '2026-01-12 17:42:36'),
(3, 'benedek_foto', 'benedek.nagy@foto.hu', '$2y$10$TuVwXyZaBcDeFgHiJkLmNo', 'Profi fotós vagyok 10+ év tapasztalattal. Főként tájkép- és esküvői fotózással foglalkozom.\r\n📸 Gear: Canon EOS R5, Sony A7IV\r\n📍 Budapest és országos\r\nKérj árat üzenetben!', 'https://example.com/kepek/fotos-profil.jpg', '2026-01-12 17:42:36'),
(4, 'tech_solutions', 'info@techsolutions.hu', '$2y$10$PqRsTuVwXyZaBcDeFgHiJk', 'IT megoldások kis- és középvállalkozásoknak. Webfejlesztés, rendszergazdai szolgáltatások, felhő migráció.\r\n✅ 24/7 támogatás\r\n✅ GDPR kompatibilis megoldások\r\n✅ Ingyenes konzultáció', 'https://example.com/kepek/ceg-logo.png', '2026-01-12 17:42:36'),
(5, 'tanarnoemi', 'nemi.tunde@iskola.edu.hu', '$2y$10$LmNoPqRsTuVwXyZaBcDeFg', 'Matematika-fizika tanár 15 év tapasztalattal. Szeretem, amikor a diákjaim felfedezik a tudomány szépségét.\r\nKészítek online oktatási anyagokat és YouTube videókat.', NULL, '2026-01-12 17:42:36'),
(6, 'zsolt_blogger', 'zsolt.blogger@blog.hu', '$2y$10$DeFgHiJkLmNoPqRsTuVwXy', 'Utazási blogger, már 30 országban jártam. Írok budget travel tippekről és rejtett kulturális élményekről.', 'https://example.com/kepek/default-avatar.png', '2026-01-12 17:42:36');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `feltoltesek`
--

CREATE TABLE `feltoltesek` (
  `id` int(11) NOT NULL,
  `felhasznalo_id` int(11) DEFAULT NULL,
  `cim` varchar(200) DEFAULT NULL,
  `leiras` text DEFAULT NULL,
  `kep_url` varchar(500) NOT NULL,
  `tipus` enum('image','short_video') NOT NULL,
  `kategoria` varchar(50) DEFAULT NULL,
  `keszul` timestamp NOT NULL DEFAULT current_timestamp(),
  `szerkesztve` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `feltoltes_cimkek`
--

CREATE TABLE `feltoltes_cimkek` (
  `feltoltes_id` int(11) NOT NULL,
  `cimke_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `follows`
--

CREATE TABLE `follows` (
  `koveto_id` int(11) NOT NULL,
  `kovetett_id` int(11) NOT NULL,
  `keszul` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kommentek`
--

CREATE TABLE `kommentek` (
  `id` int(11) NOT NULL,
  `felhasznalo_id` int(11) DEFAULT NULL,
  `feltoltes_id` int(11) DEFAULT NULL,
  `szoveg` text NOT NULL,
  `keszul` timestamp NOT NULL DEFAULT current_timestamp(),
  `szerkesztve` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `likeok`
--

CREATE TABLE `likeok` (
  `felhasznalo_id` int(11) NOT NULL,
  `feltoltes_id` int(11) NOT NULL,
  `keszul` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `cimkek`
--
ALTER TABLE `cimkek`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nev` (`nev`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fnev` (`fnev`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `feltoltesek`
--
ALTER TABLE `feltoltesek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`);

--
-- A tábla indexei `feltoltes_cimkek`
--
ALTER TABLE `feltoltes_cimkek`
  ADD PRIMARY KEY (`feltoltes_id`,`cimke_id`),
  ADD KEY `cimke_id` (`cimke_id`);

--
-- A tábla indexei `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`koveto_id`,`kovetett_id`),
  ADD KEY `kovetett_id` (`kovetett_id`);

--
-- A tábla indexei `kommentek`
--
ALTER TABLE `kommentek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `felhasznalo_id` (`felhasznalo_id`),
  ADD KEY `feltoltes_id` (`feltoltes_id`);

--
-- A tábla indexei `likeok`
--
ALTER TABLE `likeok`
  ADD PRIMARY KEY (`felhasznalo_id`,`feltoltes_id`),
  ADD KEY `feltoltes_id` (`feltoltes_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `cimkek`
--
ALTER TABLE `cimkek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `feltoltesek`
--
ALTER TABLE `feltoltesek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `kommentek`
--
ALTER TABLE `kommentek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `feltoltesek`
--
ALTER TABLE `feltoltesek`
  ADD CONSTRAINT `feltoltesek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `feltoltes_cimkek`
--
ALTER TABLE `feltoltes_cimkek`
  ADD CONSTRAINT `feltoltes_cimkek_ibfk_1` FOREIGN KEY (`feltoltes_id`) REFERENCES `feltoltesek` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feltoltes_cimkek_ibfk_2` FOREIGN KEY (`cimke_id`) REFERENCES `cimkek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`koveto_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`kovetett_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `kommentek`
--
ALTER TABLE `kommentek`
  ADD CONSTRAINT `kommentek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kommentek_ibfk_2` FOREIGN KEY (`feltoltes_id`) REFERENCES `feltoltesek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `likeok`
--
ALTER TABLE `likeok`
  ADD CONSTRAINT `likeok_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likeok_ibfk_2` FOREIGN KEY (`feltoltes_id`) REFERENCES `feltoltesek` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
