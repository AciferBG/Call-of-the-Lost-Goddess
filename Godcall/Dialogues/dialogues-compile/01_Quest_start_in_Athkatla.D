BEGIN ~AC#WMESS~

IF ~NumTimesTalkedTo(0)~ THEN BEGIN 0
  SAY @0
  IF ~~ THEN REPLY @1 GOTO 1
  IF ~~ THEN REPLY @2 GOTO 3
END

IF ~~ THEN BEGIN 1
   SAY @3
   IF ~~ THEN REPLY @4 GOTO 2
   IF ~~ THEN REPLY @5 GOTO 4
END

IF ~~THEN BEGIN 2
   SAY @6
   IF ~~ THEN DO ~OpenDoor("DOOR1010")
   SetGlobal("AC#_WaukeenMessage","GLOBAL",1)
   EscapeArea()~ EXIT
END

IF ~~ THEN BEGIN 3
   SAY @7 
   IF ~~ THEN GOTO 1
END

IF ~~ THEN BEGIN 4
   SAY @8 
   IF ~~ THEN DO ~EscapeArea()~ EXIT
END

APPEND GOVWAU01

// Patching the first dialogue of the Waukeenar priest to react to the player's liberation of Waukeen
IF WEIGHT #-999 ~GlobalGT("AC#WaukeenWorldKnows","GLOBAL",0)
Global("AC#WaukeenReaction","AR1010",0)~ THEN BEGIN hello_hero
   SAY @39
   =
   @40
   IF ~~ THEN DO ~SetGlobal("AC#WaukeenReaction","AR1010",1)~ GOTO what_can_i_do
END

IF WEIGHT #-998 ~Global("AC#WaukeenWorldKnows","GLOBAL",0)
GlobalGT("AC#WCelebration","GLOBAL",0)
Global("AC#WaukeenReaction","AR1010",0)~ THEN BEGIN hello_unknown_hero
   SAY @47
   IF ~~ THEN DO ~SetGlobal("AC#WaukeenReaction","AR1010",1)~ GOTO what_can_i_do
END

IF ~~ THEN BEGIN Waukeen2
   SAY @9
   =
   @10
   IF ~~ THEN REPLY @11 GOTO Waukeen3
   IF ~~ THEN REPLY @12 GOTO Waukeen3
END

IF ~~ THEN BEGIN Waukeen3
   SAY @13
   IF ~ReputationGT(LastTalkedToBy,16)~ THEN GOTO Good
   IF ~ReputationLT(LastTalkedToBy,17)
       ReputationGT(LastTalkedToBy,8)~ THEN GOTO Neutral
   IF ~ReputationLT(LastTalkedToBy,9)~ THEN GOTO Evil
END

IF ~~ THEN BEGIN Good
   SAY @14
   IF ~Global("Kayl1Done","GLOBAL",1)~ THEN GOTO KAYL
   IF ~!Global("Kayl1Done","GLOBAL",1)
   Global("SculptorDone","GLOBAL",1)~ THEN GOTO SARLES
   IF ~OR(2)
   !Global("SculptorDone","GLOBAL",1)
   !Global("Kayl1Done","GLOBAL",1)~ THEN GOTO Goldspires
END

IF ~~ THEN BEGIN Neutral
   SAY @15
   IF ~Global("Kayl1Done","GLOBAL",1)~ THEN GOTO KAYL
   IF ~!Global("Kayl1Done","GLOBAL",1)
   Global("SculptorDone","GLOBAL",1)~ THEN GOTO SARLES
   IF ~OR(2)
   !Global("SculptorDone","GLOBAL",1)
   !Global("Kayl1Done","GLOBAL",1)~ THEN GOTO Goldspires
END

IF ~~ THEN BEGIN Evil
   SAY @16
   IF ~Global("Kayl1Done","GLOBAL",1)~ THEN GOTO KAYL
   IF ~!Global("Kayl1Done","GLOBAL",1)
   Global("SculptorDone","GLOBAL",1)~ THEN GOTO SARLES
   IF ~OR(2)
   !Global("SculptorDone","GLOBAL",1)
   !Global("Kayl1Done","GLOBAL",1)~ THEN GOTO Goldspires
END

IF ~~ THEN BEGIN KAYL
   SAY @17
   IF ~Global("SculptorDone","GLOBAL",1)~ THEN GOTO SARLES
   IF ~!Global("SculptorDone","GLOBAL",1)~THEN GOTO Goldspires
END

IF ~~ THEN BEGIN SARLES
   SAY @18
   IF ~~ THEN GOTO Goldspires
END

IF ~~ THEN BEGIN Goldspires
   SAY @19
   IF ~~ THEN REPLY @22 GOTO Accept
   IF ~~ THEN REPLY @21 GOTO Accept
   IF ~~ THEN REPLY @38 GOTO Refuse
   IF ~~ THEN REPLY @20 GOTO Refuse
END

IF ~~ THEN BEGIN Refuse
   SAY @23
   IF ~~ THEN GOTO Reveal
END

IF ~~ THEN BEGIN Accept
   SAY @24
   IF ~~ THEN GOTO Reveal
END

IF ~~ THEN BEGIN Reveal
   SAY @25
   IF ~~ THEN DO ~SetGlobal("AC#_WaukeenMessage","GLOBAL",2)
   AddJournalEntry(@100010,QUEST)
   RevealAreaOnMap("AC#W01")~
EXIT
END

IF ~~ THEN BEGIN Waukeen_do_you_recognise_me
   SAY @43
   IF ~~ THEN GOTO what_can_i_do
END

IF ~~ THEN BEGIN Waukeen_free_dont_know
   SAY @44
   IF ~~ THEN GOTO what_can_i_do
END

IF ~~ THEN BEGIN what_can_i_do 
  SAY @45
  IF ~~ THEN REPLY #58452 /* ~Ich würde gern Eure Dienste in Anspruch nehmen, bitte.~ */ GOTO service
  IF ~~ THEN REPLY #58453 /* ~Nichts. Ich gehe jetzt.~ */ GOTO bye_nothing
END

IF ~~ THEN BEGIN service
  SAY #58446 /* ~Natürlich. Die Anhänger Waukeens sind immer bereit, zu dienen … zu einem fairen und ehrlichen Preis, versteht sich.~ */
  IF ~~ THEN DO ~StartStore("govwau01",LastTalkedToBy)~ EXIT
END

IF ~~ THEN BEGIN bye_nothing
  SAY @46
  IF ~~ THEN EXIT
END
END

// Patching the "I thought Waukeen was dead?" response.
ADD_TRANS_TRIGGER GOVWAU01 0 ~Global("AC#WCelebration","GLOBAL",0)~ DO 0

EXTEND_BOTTOM GOVWAU01 0
        IF ~Global("AC#_WaukeenMessage","GLOBAL",1)~ THEN REPLY @26 GOTO Waukeen2
END		
EXTEND_BOTTOM GOVWAU01 0
        IF ~GlobalGT("AC#WaukeenWorldKnows","GLOBAL",0)~ THEN REPLY @41 GOTO Waukeen_do_you_recognise_me	
END
EXTEND_BOTTOM GOVWAU01 0
        IF ~GlobalGT("AC#WCelebration","GLOBAL",0)
		Global("AC#WaukeenWorldKnows","GLOBAL",0)~ THEN REPLY @42 GOTO Waukeen_free_dont_know			
END

BEGIN ~AC#WGIL1~

IF ~NumTimesTalkedTo(0)~ THEN BEGIN 0
   SAY @27 
   IF ~~ THEN REPLY @28 GOTO 1
   IF ~~ THEN REPLY @29 GOTO 2
END

IF ~~ THEN BEGIN 1
   SAY @30
   =
   @31
   IF ~~ THEN REPLY @32 GOTO 3
   IF ~~ THEN REPLY @33 GOTO 4
END

IF ~~ THEN BEGIN 2
   SAY @34
   IF ~~ THEN REPLY @35 GOTO 1
END

IF ~~ THEN BEGIN 3
   SAY @36
   IF ~~ THEN DO ~SetGlobal("AC#W_Gildaar","GLOBAL",2)
   AddJournalEntry(@110000,QUEST)
   EscapeArea()~ EXIT
END

IF ~~ THEN BEGIN 4
   SAY @37
   IF ~~ THEN DO ~SetGlobal("AC#W_Gildaar","GLOBAL",2)
   AddJournalEntry(@110000,QUEST)
   EscapeArea()~ EXIT
END


