-- CreateTable
CREATE TABLE "NormalizedLocation" (
    "id" SERIAL NOT NULL,
    "country" TEXT,
    "countryShort" TEXT,
    "stateProv" TEXT,
    "stateProvShort" TEXT,
    "formattedAddress" TEXT,
    "city" TEXT,
    "name" TEXT,
    "street" TEXT,
    "postalCode" TEXT,
    "streetNumber" TEXT,
    "placeDetails" BYTEA,
    "placeId" TEXT,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "eventId" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NormalizedLocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DistrictTeam" (
    "id" SERIAL NOT NULL,
    "districtId" INTEGER NOT NULL,
    "teamNumber" INTEGER NOT NULL,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DistrictTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventTeam" (
    "id" SERIAL NOT NULL,
    "status" BYTEA,
    "teamId" INTEGER NOT NULL,
    "eventId" INTEGER NOT NULL,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EventTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MatchTeam" (
    "id" SERIAL NOT NULL,
    "teamKey" TEXT,
    "teamId" INTEGER NOT NULL,
    "matchId" INTEGER NOT NULL,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MatchTeam_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Award" (
    "id" SERIAL NOT NULL,
    "eventId" INTEGER,
    "awardType" INTEGER,
    "nameStr" TEXT,
    "recipientList" JSONB[],
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Award_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Event" (
    "id" SERIAL NOT NULL,
    "parentEventId" INTEGER,
    "name" TEXT,
    "eventDistrict" INTEGER,
    "eventType" INTEGER,
    "eventShort" TEXT,
    "firstCode" TEXT,
    "shortName" TEXT,
    "playoffType" INTEGER,
    "facebookEid" TEXT,
    "website" TEXT,
    "webcastUrl" TEXT,
    "webcastJson" JSONB,
    "oprTeams" INTEGER[],
    "oprs" DOUBLE PRECISION[],
    "customHastag" TEXT,
    "districtKey" TEXT,
    "enablePredictions" BOOLEAN NOT NULL,
    "remapTeams" BYTEA,
    "rankings" JSONB,
    "matchStats" JSONB,
    "venue" TEXT,
    "city" TEXT,
    "venueAddress" TEXT,
    "stateProv" TEXT,
    "postalCode" TEXT,
    "country" TEXT,
    "location" TEXT,
    "official" BOOLEAN,
    "divisions" TEXT[],
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "timezoneId" TEXT,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "District" (
    "id" SERIAL NOT NULL,
    "displayName" TEXT,
    "rankings" BYTEA,
    "advancement" BYTEA,
    "elasticSearchName" TEXT,
    "abbreviation" TEXT,
    "eventId" INTEGER,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "District_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Match" (
    "id" SERIAL NOT NULL,
    "matchNumber" INTEGER,
    "game" TEXT,
    "compLevel" TEXT,
    "predictedTime" TIMESTAMP(3),
    "time" TIMESTAMP(3),
    "timeString" TEXT,
    "postResultTime" TIMESTAMP(3),
    "actualTime" TIMESTAMP(3),
    "tbaVideos" TEXT[],
    "setNumber" INTEGER,
    "noAutoUpdate" BOOLEAN,
    "pushSent" BOOLEAN,
    "alliances" JSONB,
    "scoreBreakdown" JSONB,
    "youtubeVideos" TEXT[],
    "tiebreakMatchKey" TEXT,
    "eventId" INTEGER,
    "year" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Match_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventDetails" (
    "id" SERIAL NOT NULL,
    "rankings" BYTEA,
    "matchStates" BYTEA,
    "districtPoints" BYTEA,
    "allianceSelections" BYTEA,
    "predictions" BYTEA,
    "playoffAdvancement" BYTEA,
    "rankings2" BYTEA,
    "insights" BYTEA,
    "eventId" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EventDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_AwardToTeam" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_AwardToTeam_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "NormalizedLocation_eventId_key" ON "NormalizedLocation"("eventId");

-- CreateIndex
CREATE UNIQUE INDEX "EventDetails_eventId_key" ON "EventDetails"("eventId");

-- CreateIndex
CREATE INDEX "_AwardToTeam_B_index" ON "_AwardToTeam"("B");

-- AddForeignKey
ALTER TABLE "NormalizedLocation" ADD CONSTRAINT "NormalizedLocation_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DistrictTeam" ADD CONSTRAINT "DistrictTeam_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES "District"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DistrictTeam" ADD CONSTRAINT "DistrictTeam_teamNumber_fkey" FOREIGN KEY ("teamNumber") REFERENCES "Team"("teamNumber") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventTeam" ADD CONSTRAINT "EventTeam_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventTeam" ADD CONSTRAINT "EventTeam_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MatchTeam" ADD CONSTRAINT "MatchTeam_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MatchTeam" ADD CONSTRAINT "MatchTeam_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES "Match"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Award" ADD CONSTRAINT "Award_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Event" ADD CONSTRAINT "Event_parentEventId_fkey" FOREIGN KEY ("parentEventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "District" ADD CONSTRAINT "District_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Match" ADD CONSTRAINT "Match_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventDetails" ADD CONSTRAINT "EventDetails_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AwardToTeam" ADD CONSTRAINT "_AwardToTeam_A_fkey" FOREIGN KEY ("A") REFERENCES "Award"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AwardToTeam" ADD CONSTRAINT "_AwardToTeam_B_fkey" FOREIGN KEY ("B") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;
