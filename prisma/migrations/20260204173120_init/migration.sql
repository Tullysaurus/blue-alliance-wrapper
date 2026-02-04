-- CreateEnum
CREATE TYPE "WebcastEnum" AS ENUM ('youtube', 'twitch', 'ustream', 'iframe', 'html5', 'rtmp', 'livestream', 'direct_link', 'mms', 'justin', 'stemtv', 'dacast');

-- CreateTable
CREATE TABLE "Event" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "eventCode" TEXT NOT NULL,
    "eventType" INTEGER NOT NULL,
    "city" TEXT,
    "stateProv" TEXT,
    "country" TEXT,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "year" INTEGER NOT NULL,
    "shortName" TEXT,
    "eventTypeString" TEXT NOT NULL,
    "address" TEXT,
    "postalCode" TEXT,
    "gmapsPlaceId" TEXT,
    "gmapsUrl" TEXT,
    "lat" DOUBLE PRECISION,
    "lng" DOUBLE PRECISION,
    "locationName" TEXT,
    "timezone" TEXT,
    "website" TEXT,
    "firstEventId" TEXT,
    "firstEventCode" TEXT,
    "divisionKeys" TEXT[],
    "parentEventKey" TEXT,
    "playoffType" INTEGER,
    "playoffTypestring" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "District" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "abbreviation" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "eventId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "District_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Webcast" (
    "id" SERIAL NOT NULL,
    "type" "WebcastEnum" NOT NULL,
    "channel" TEXT NOT NULL,
    "date" TIMESTAMP(3),
    "file" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Webcast_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_EventToWebcast" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_EventToWebcast_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "District_key_key" ON "District"("key");

-- CreateIndex
CREATE UNIQUE INDEX "District_eventId_key" ON "District"("eventId");

-- CreateIndex
CREATE INDEX "_EventToWebcast_B_index" ON "_EventToWebcast"("B");

-- AddForeignKey
ALTER TABLE "District" ADD CONSTRAINT "District_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToWebcast" ADD CONSTRAINT "_EventToWebcast_A_fkey" FOREIGN KEY ("A") REFERENCES "Event"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToWebcast" ADD CONSTRAINT "_EventToWebcast_B_fkey" FOREIGN KEY ("B") REFERENCES "Webcast"("id") ON DELETE CASCADE ON UPDATE CASCADE;
