---------------こっこAI ⊂(*'ω')⊃  Ver6.13 ---------------------------------------------

-- 機能詳細，設定マニュアルなどは以下のURLから確認してください．
-- http://cocco.privatemoon.jp/

----------------------------Editing by 冠月ユウ-----------------------------------------------------
InitialFlag				= true
function Initialize()
TraceAI("----- Initialize : Type "..GetV(V_HOMUNTYPE,MyID).."  MyID "..MyID.."----- ")
------------------------------*-*-*-*-*-*-*-*-*--------------------------------
-- グローバル変数(カスタム）
-- 数値を変更することで設定を変えられるものにはコメント先頭に●が付いています
-- それ以外の変数は基本的に変更しないでください！
-------------------------------------------------------------------------------
MyOwner					= GetV(V_OWNER,MyID)			-- 主人のID取得
MyType					= GetV(V_HOMUNTYPE,MyID)			-- ホムンクルスのタイプを記録
MyPreType				= 0									-- 変異前タイプ
-- ディレクトリ指定（使わない方をコメントアウト：両方コメントアウトするとエラーになります）
SaveDir	= "AI/"
--SaveDir	= "AI/USER_AI/"

-- Cocco_USER_AI.txtによるディレクトリ判定
if not io.open("AI/Cocco_USER_AI.txt") and io.open("AI/USER_AI/Cocco_USER_AI.txt") then
	SaveDir	= "AI/USER_AI/"		-- USER_AIの中だけにCocco_USER_AI.txtがある時は、USER_AIフォルダとして扱う
end
-- 自分と主人のオブジェクト----------------------------------------------------------------------------------------------------
MakeActor(MyID)
MakeActor(MyOwner)
-- ステータス管理に関する変数----------------------------------------------------------------------------------------------------
HomHP_Per				= GetPerHP(MyID)				-- ホムンクルスのHP％
HomSP_Per				= GetPerSP(MyID)				-- ホムンクルスのSP％
OwnerHP_Per				= GetPerHP(MyOwner)				-- 主人のHP％
OwnerSP_Per				= GetPerSP(MyOwner)				-- 主人のSP％
StatusCheckCycle		= GetTick()						-- チェックサイクル

-- 旋回動作に関する変数 ---------------------------------------------------------------------------------------------------------
RondoFlag				= true			-- ●旋回動作を行うか否か（trueかfalse で設定
PatrolRest				= 90			-- ●ホムの残りHP･SPがこの％以下の場合は静止（回復のため）
PatrolInterval			= 15000			-- ●一回転してから次に回転するまでの間隔
RondoPattern			= 1				-- ●旋回動作のパターン　1：その場で小旋回　2：主人の回りを小旋回
RondoRadius				= 1				-- ●旋回動作の半径
StepDelay				= 0				-- ●旋回動作の1ステップの時間
RondEnd					= os.time()		-- 旋回間隔の時間管理
MoveDelay				= 0				-- くるくる速度のための設定（初期値0のままでok）
Rdx , Rdy				= 0,0			-- くるくる目標座標
PatrolVector			= 0				-- 現在のくるくる方向（初期値0のままでok）
VectorEnd				= 0				-- 移動回数設定
NowRondo				= false			-- 回転動作中

-- 等速追従に関する変数 ---------------------------------------------------------------------------------------------------------
DifferentialAccuracy	= 140			-- ●移動パケットを送る間隔（短いほど高負荷　長いほど低負荷だが追従が遅れる
ChaseDistance			= 2				-- ●主人を追跡する時にとる距離（1か2で設定．それ以外では不具合が起きます
FollowDistance			= 3				-- ●指定セルより離れたら追従を開始する
ToOwnerSide				= 0				-- ●追従時の目標座標を左右にずらす　右：1　左：-1
MoveStackCheck			= true			-- スタックチェックするか

-- オートスキルに関する変数 ---------------------------------------------------------------------------------------------------------
AutoAttackSkill			= true			-- ●自動攻撃スキルを使用するか否か（trueかfalse で設定
AutoBufferSkill			= true			-- ●自動強化スキルを使用するか否か（trueかfalse で設定
AutoRecoverSkill		= false			-- ●自動回復スキルを使用するか否か（trueかfalse で設定
AutoSkill				= 0				-- ●ホムの自動スキル最低発動確率％（＋残りSPにより変動）
AutoSkillSPLimit		= 20			-- ●ホムのSPがこの％を下回った場合には自動スキル発動なし
AutoSkillSPLimit2		= 100			-- ●ホムのSPがこの％を上回った場合には自動スキル発動なし
AutoSkillSPPer			= 1				-- ●AutoSkillSPLimitの数字を％として扱うか否か（0の場合は絶対値）
AutoSkillSPPer2			= 1				-- ●AutoSkillSPLimit2の数字を％として扱うか否か（0の場合は絶対値）
AS_SkillLevel			= 5				-- ●使用するムーンライト，カプリスのスキルLv（1～5で設定
AutoAdjust				= true			-- ●自動攻撃スキルのレベルを自動調節するか否か（trueかfalse で設定
AutoAdjustPoint			= true			-- ●自動範囲スキルの展開地点を調節するか否か（true：調整座標 false：ターゲット
AS_threshold = {1500,2000,3000,4000,5000}	-- ●自動レベル調節の閾値．ミリ秒指定（戦闘時間が～閾値1：未使用，閾値1～2：Lv1，…
BufferLevel				= 1				-- ●オートフリットムーブの使用レベル（1～5で設定
BufferLimit				= 0				-- ●敵の数が指定数以上の時オートフリットムーブ発動
RecoverLevel			= 3				-- ●オートリカバーの使用レベル（1～5で設定
AutoBufferHP			= 100			-- ●オート強化スキルが発動する主人のHPの割合（％）
AutoBufferMyHP			= 100			-- ●オート強化スキルが発動する自分のHPの割合（％）
AutoRecoverHP			= 50			-- ●オートリカバーが発動する主人のHPの割合（％）
AutoRecoverMyHP			= 30			-- ●オートリカバーが発動する自分のHPの割合（％）
AutoDurationCut			= 100			-- ●オートスキルの持続時間が指定（％）したときかけ直す（デフォルトは100％）
CV_NoEnemy				= true			-- ●カオティックベネディクションを敵がいない時のみの発動に制限するか否か
EmergencyAvoid			= true			-- ●移動時に自動で緊急回避を使用するか否か（trueかfalse で設定
EA_Level				= 1				-- ●自動緊急回避の使用レベル（1～5で設定
MentalChangeAlert		= 10			-- ●メンタルチェンジの終了時間が指定秒前になると旋回動作でアラートする（0ならアラートしない
AspCoefficient			= 10			-- ●SP依存のAS確率計算式の係数
AspExponential			= 2				-- ●SP依存のAS確率計算式の指数
AttackLimit				= 0				-- ●敵の数が指定数以上で発動
RegionResetRate			= 0				-- ●サモンレギオンの持続時間を強制かけ直しする経過時間の割合（％）
SkillDelay				= 0				-- スキルディレイ管理
OnCasting				= 0				-- 詠唱時間管理
AdditionalProb			= 0				-- 追加確率管理
BufferLevel2			= 1				-- オートオーバードスピードの使用レベル（設定により変動
FirstAid				= true			-- 治癒の手管理用フラグ
beforeHP				= 0				-- 治癒の手管理用主人HP
AST_Number				= 0				-- オートスキルテーブル管理
useSkill				= false			-- オートスキル使用フラグ管理
-- スキル使用に関する変数 ---------------------------------------------------------------------------------------------------------
LongRangeSkill			= true			-- ●手動スキルを遠距離から放つか否か（trueかfalse で設定
FirstAttack				= false			-- ●初撃スキル攻撃をするか否か（trueかfalse で設定
FA_SkillLevel			= 1				-- ●初撃スキルの使用レベル（1～5で設定
FA_OnChase				= false			-- ●追跡の段階で遠距離から初撃スキルをするか否か
LimitSBR				= false			-- ●S.B.Rを撃つ相手を制限するか否か（trueかfalse で設定
SBR_Target				= {}			-- ●S.B.Rを撃つ相手の種族IDを指定
CrossFire				= false			-- ●主人のスキルモーション検知時にオートスキルを100％使用
CanselManualSkill		= function() end	-- マニュアル使用をキャンセルする
-- AS確率操作に関する変数 ---------------------------------------------------------------------------------------------------------
ASP_Increase			= 10			-- ●上昇させる％値
ASL_Increase			= 1				-- ●上昇させるスキルLv
ASP_Decrease			= 10			-- ●減少させる％値
ASL_Decrease			= 1				-- ●減少させるスキルLv

-- 退避行動に関する変数 ---------------------------------------------------------------------------------------------------------
EscapePattern			= 0				-- ●ホム危険時，敵から退避するパターン
EscapeRange				= 3				-- ●ホム危険時，主人の何マス後ろへ隠れるか
EscapeDirection			= 0				-- ●後ろへ隠れる設定の場合，後ろ以外の方向に変更

-- アクティブ状態に関する変数 ---------------------------------------------------------------------------------------------------------
TargetDistance 			= 7				-- ●タゲに選択する敵のケミからの距離の制限 3～14程度なら動くはず
ActiveFlag				= false			-- ●アクティブデフォルト設定 falseがノンアクティブ trueがアクティブ
ActiveRange				= true			-- ●索敵範囲を他人との距離に応じて変化させるか否か
LimitRangeDist			= 6				-- ●この距離以内に人が居る場合は，アクティブ索敵しない
HalfActive				= true			-- ●任意のMobはアクティブに攻撃しにいく
ActiveHP				= 40			-- ●指定％以下のHPの時はノンアクティブ
ActiveSP				= 0				-- ●指定％以下のSPの時はノンアクティブ
OthersRange				= 4				-- ●ターゲットの指定セル以内に他プレイヤーが居る場合はターゲットリセット
ActiveSwitch			= true			-- ●主人が座っている時にAlt+Tで休息→待機に復帰する際、アクティブ/ノンアクティブの切替をするか否か

-- 通常攻撃に関する変数 ---------------------------------------------------------------------------------------------------------
FollowOwnerTargetting 	= false			-- ●主人のタゲを最優先にするかどうか　（する→true　　しない→false
OnBattleDistance		= 7				-- ●戦闘中、この距離以上主人が離れると戦闘を中断して追従
OnBattleDistancePlus	= 10			-- ●友達が居る場合、OnBattleDistanceを指定数のセルまで拡張する．拡張不要であれば上記と同値に．
OBD_Neutral				= OnBattleDistance	-- 初期値を記憶
AttackDistance			= 1				-- ●攻撃する時の敵との距離．（1か2以外では不具合の恐れ
MultiAttack				= 2				-- ●1サイクルの攻撃回数（攻撃モーションキャンセル：値域1～3，数字の数だけ攻撃コマンド
RobTarget				= 0				-- ●主人を攻撃している敵のタゲ集めの数
OverlapFlag 			= 0				-- 戦闘中、敵と重なったときに移動するためのフラグ変数
AttackedFlag			= false			-- 攻撃管理

-- 座標重なり回避に関する変数 ---------------------------------------------------------------------------------------------------------
HateOverlap				= true			-- ●セル重なり回避をするか否か（trueかfalse で設定
AwayType				= 1				-- ●回避タイプ（0：絶対方向（AvoidDirectionで指定），1：相対方向（常に敵の背後へ））
AwayStep				= 2				-- ●セル重なり回避のときに移動するセル数
AvoidDirection			= {{x=1,y=0},{x=0,y=-1},{x=-1,y=0},{x=0,y=1}}		-- ●重なり回避の退避方向（-1～1でx,y方向指定）
AwayCount				= TableSize(AvoidDirection)							-- 重なり回避の時の移動試行回数

-- 友達登録に関する変数 ---------------------------------------------------------------------------------------------------------
AutoFriend				= true			-- ●自動友達登録するか否か
TamedDegree				= 20			-- ●自動友達登録の懐きやすさ．20～40前後がよいと思われる．低いとすぐ登録するが，誤登録の可能性も．
Neighbor				= 0				-- 友達の可能性がある人のID
NeighborTime			= 0				-- 時間管理
FriendList				= {}			-- 友達リスト
SameTargetCount			= 0				-- タゲ被り回数
HomFriendList			= {}			-- ホムンクルスの友達リスト（ホムIDはロードごとリセット
OtherHoms				= {}			-- 友達ではないホム一覧
-- 射撃状態に関する変数 ---------------------------------------------------------------------------------------------------------
ShootingMode			= false			-- ●戦闘は常に射撃状態で行うか否か
ShootLevel				= 3				-- ●射撃状態時に使用するスキルのスキルLv
EscapeOnShooting		= true			-- ●射撃状態時に接敵された場合に退避するか否か
PatrolPattern			= 6				-- ●射撃状態時に接敵された場合，退避する旋回パターン（待機時旋回と同様）
PatrolRange				= 3				-- ●射撃状態時に接敵された場合，退避する距離（主人からの距離）

-- 共闘モード関する変数 ----------------------------------------------------------------------------
BonusMode				= false			-- ●共闘モードにするかどうか
BonusTime				= 500			-- ●指定ミリ秒間だけ攻撃する
BonusTimeRate			= 0				-- ●平均戦闘時間データがある場合、指定％の時間まで攻撃する（0で無効）
BonusBorder				= 3				-- ●こちらをターゲットしている敵の数が指定数以上の場合は共闘モードを一時解除
BonusFlag				= false			-- 共闘モード管理フラグ

-- 詠唱妨害関する変数 ----------------------------------------------------------------------------
PreventEnemyCasting		= true						-- ●詠唱妨害するかどうか
PreventSkillLevel		= 1							-- ●詠唱妨害スキルのレベル

-- SP回復待ちに関する変数 ----------------------------------------------------------------------------
WaitSPR					= false						-- ●4秒に1回のSPRを待ち，タイミング次第で移動を制限する
SPR_Wait				= 3							-- ●指定秒数以上移動しない時間が続いたら，4秒まで待つ
SPR_Rate				= 80						-- ●SP量が指定％以下のときにSPR待ちをする
MyRestPosX,MyRestPos	= 0,0						-- 滞在位置
SPR_Flag				= false						-- SPR管理フラグ
StayTime				= os.time()					-- 滞在時間
PreSP					= 0							-- 回復前SP

-- 先行移動に関する変数 ----------------------------------------------------------------------------
OnForward				= false			-- ●移動時にホムンクルスが先導するか否か
ForwardDistance			= 3				-- ●先行する距離

-- フック攻撃に関する変数 ----------------------------------------------------------------------------
HookShot				= false			-- ●敵をフックするか否か

-- スタックチェックに関する変数 ----------------------------------------------------------------------------
AttackFalseCheck		= true			-- ●攻撃スタックをチェックする
StandTime				= 0				-- 停止時間
StackDist				= 0				-- スタック時の距離
AttackFalseCount		= 0				-- 攻撃ミス回数
AttackFalseTime			= GetTick()		-- 攻撃ミス時間
AroundMoveFlag			= 0				-- 迂回動作管理フラグ
AroundLog				= {x=0,y=0,t=0}				-- 迂回方向ログ
MoveShift				= false
preDestX, preDestY		= 0, 0			-- 移動シフト

-- サーチングに関する変数 ----------------------------------------------------------------------------
TargetObjects			= { 111 , 113 }			-- ターゲットフラグ
SearchedObject			= 0				-- 探索対象ID

-- メッセージ出力に関する変数 ----------------------------------------------------------------------------
PrintMsg				= true					-- ●メッセージを専用ウィンドウに出力するか否か
PrintTalk				= true					-- ●メッセージウィンドウにトークメッセージを出力するか否か
msgList = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}		-- メッセージリスト
PrintableFlag			= true					-- プリントフラグ
PrintTimeOut			= os.time()				-- 時間管理
MsgHoldTime				= 0						-- 表示時間管理
EDIT_ST					= 100
TRIGGER_ST				= 101
MODE_ST					= 102

-- マッピングに関する変数 ----------------------------------------------------------------------------
LocalMap				= {}					--毎時スキャン用
GlobalMap				= {}					--固定用
MovedGreen				= {}					--移動記録用

-- その他の変数 ---------------------------------------------------------------------------------------------------------
MoveToStay				= false			-- ●移動命令後，休息状態にする
SleepFlag				= true			-- ●スリープフラグ(falseにするとスリープしない
SleepTime				= 1000			-- ●スリープ時間（ミリ秒）
MC_AlertPattern			= 9				-- ●MChアラートのパターン
MovingCancel			= false			-- ●移動によるモーションキャンセル
MovingSP				= 30			-- ●モーションキャンセルはSPがこれ以上のとき限定
MovingHP				= 0				-- ●モーションキャンセルはHPがこれ以上のとき限定
MC_AlertFlag			= false			-- MChアラート用フラグ
StayFlag				= false			-- 移動命令時の留まりを管理
OurEnemys				= {}			-- 敵リスト
OurEnemysCount			= 0				-- 敵の数
LostEnemy				= 0				-- さっき倒した敵
LostTime				= 0				-- さっき倒した時間
LastState				= 0 			-- 直前の状態
StepCommand				= {0,0,0}		-- ステップコマンド格納
SCIndex					= 0				-- ステップコマンド用インデックス
T_TriggerTime			= 0				-- Alt+Tタイミング管理
ReturnFlag				= false			-- リターンフラグ
LagCheckFlag			= false			-- ラグチェック
re_msg					= {NONE_CMD}	-- 予約コマンド
ScannedTick				= 0				-- スキャン時間管理
ScanningTime			= 250			-- スキャンサイクル時間
GetPreTick				= 0				-- 時間管理

-- 平均戦闘時間に関する変数 ----------------------------------------------------------------------------
MobFilename				= "Mob"
RecordBattleTime		= true			-- ●敵ごとに平均戦闘時間を記録する
RecCount				= 10			-- ●戦闘時間の平均を取るサンプル数
KillCount				= {}			-- 内部キルカウント
DistTime				= {}			-- 撃破時間

-- 登録操作系編集に関する変数 ----------------------------------------------------------------------------
-- デフォルトの操作系をある程度カスタマイズできます．組み合わせによっては作動しないこともあります
ALT_SHIFT_CELL_CLICK		= EDIT_FRIEND			-- Alt+Shift+地面右クリック
ALT_SHIFT_OWNER_CLICK		= EDIT_FRIEND_ALL		-- Alt+Shift+主人の居るセル右クリック
ALT_SHIFT_MY_CLICK			= EDIT_FRIEND_DEL		-- Alt+Shift+自分の居るセル右クリック
ALT_D_CLICK					= EDIT_RANK				-- ●Alt+対象ダブル右クリック
ALT_D_CLICK_SIT				= EDIT_BONUS			-- ●主人が座ってる時，Alt+対象ダブル右クリック
ALT_SHIFT_CLICK				= EDIT_RAID				-- ●Alt+Shift+対象右クリック
ALT_SHIFT_CLICK_SIT			= EDIT_SKILLT			-- ●主人が座ってる時，Alt+Shift+対象右クリック
ALT_T_SHIFT_CLICK			= EDIT_IGNORE			-- ●休息状態時，Alt+Shift+対象右クリック
ATTACKSKILL_LV1				= EDIT_SKILL			-- ●攻撃スキルLv1を使用
ATTACKSKILL_LV2				= EDIT_CAST				-- ●攻撃スキルLv2を使用
ALT_T_ATTACKSKILL			= EDIT_SKILL_LEVEL		-- ●休息状態時，攻撃スキルを使用

-- トリガー系編集に関する変数 ----------------------------------------------------------------------------
-- 特定の条件に任意の機能やパラメータ変動を割り当てることが出来ます．
MANY_ENEMYS					= {TRIGGER_ASP_INC,TRIGGER_ASL_INC}		-- ●敵の数がEnemyBorder_N以上の時の行動
TOUGH_ENEMY					= {TRIGGER_ASP_INC}						-- ●平均戦闘時間記録がEnemyBorder_T以上の時の行動
ALT_T_TO_REST				= {}									-- ●Alt+Tで待機→休息状態に移行する時の行動
ALT_T_TO_IDLE				= {}									-- ●Alt+Tで休息→待機状態に移行する時の行動
ALT_MY_CLICK				= {TRIGGER_OnSEARCH}					-- ●自分の居るセルをAlt+右クリックしたときの行動
ALT_OWNER_CLICK				= {}									-- ●主人の居るセルをAlt+右クリックしたときの行動
ALT_FRIEND_CLICK			= {TRIGGER_CHANGE_OWNER}				-- ●友達の居るセルをAlt+右クリックしたときの行動
MY_HP_UNDER_SAFETY			= {TRIGGER_OnESCAPE}					-- ●自分のHPがHomunculusSafetyHPで指定した％以下になった時の行動
MY_SP_UNDER_SAFETY			= {}									-- ●自分のSPがHomunculusSafetyHPで指定した％以下になった時の行動
OWNER_HP_UNDER_SAFETY		= {}									-- ●主人のSPがHomunculusSafetyHPで指定した％以下になった時の行動
OWNER_SP_UNDER_SAFETY		= {}									-- ●主人のSPがHomunculusSafetyHPで指定した％以下になった時の行動
MY_HP_EMERGENCY				= {}									-- ●自分のHPが1秒間でFallMyHpRateで指定した％以上減った時の行動
MY_SP_EMERGENCY				= {}									-- ●自分のSPが1秒間でFallMySpRateで指定した％以上減った時の行動
OWNER_HP_EMERGENCY			= {}									-- ●主人のHPが1秒間でFallOwnerHpRateで指定した％以上減った時の行動
OWNER_SP_EMERGENCY			= {}									-- ●主人のSPが1秒間でFallOwnerSpRateで指定した％以上減った時の行動
OWNER_MOTION				= {}									-- ●主人のモーションがT_OwnerMotionで指定した状態である時の行動
-- トリガーに関係する設定変数
HomunculusSafetyHP			= 30					-- ●自分のHPが指定％以下のとき，任意の行動をとる
HomunculusSafetySP			= 60					-- ●自分のSPが指定％以下のとき，任意の行動をとる
OwnerSafetyHP				= 30					-- ●主人のHPが指定％以下のとき，任意の行動をとる
OwnerSafetySP				= 20					-- ●主人のSPが指定％以下のとき，任意の行動をとる
EnemyBorder_N				= 3						-- ●敵の数が指定数以上のとき，任意の行動をとる
EnemyBorder_T				= 7000					-- ●ターゲットの平均戦闘時間が指定ミリ秒以上の時，任意の行動を取る
T_MoveDirection				= {-3,3}				-- ●トリガー発行時，現在地から指定の相対座標へ移動（デフォルト：北3西3セルへ）
T_OwnerMotion				= -1					-- ●主人のモーションが指定のとき，任意の行動をとる
FallMyHpRate			= 20							-- ●1秒間に自分のHPが低下する時の閾値％
FallMySpRate			= 5								-- ●1秒間に自分のSPが低下する時の閾値％
FallOwnerHpRate			= 20							-- ●1秒間に主人のHPが低下する時の閾値％
FallOwnerSpRate			= 5								-- ●1秒間に主人のSPが低下する時の閾値％

-- モードチェンジに関する変数 ----------------------------------------------------------------------------
QuickTrigger			= false						-- ●Alt+T連打によるスイッチを使うか否か
SettingList				= {3,4,1}					-- ●設定リスト（リーフ：1 アミストル：2 フィーリル：3 バニルミルト：4）
ModeIndex				= 1							-- モードインデックス

------------------------------------
--追加グローバル変数
------------------------------------
AroundFlag = false
AroundV = {x1=0,x2=0,y1=0,y2=0}
tpcCheck = GetTick()
-- 優先度関する変数 ----------------------------------------------------------------------------
RecType = 60						-- ●弱い順：60 強い順:0
NoRecEnemy = 0						-- ●レコードが無い敵の倍率
TargetPriorityRate = 10				-- ●採点倍率
-------------------------------------
-- TargetPriority配列
-- それぞれに条件倍率を設定する
-- 重視したい条件ほど数値を高く設定
-------------------------------------
TargetPriority[TP_En2Ow]	= 9			-- ●敵→主人
TargetPriority[TP_En2Me]	= 8			-- ●敵→自分
TargetPriority[TP_En2Fr]	= 6			-- ●敵→友達
TargetPriority[TP_Ow2En]	= 10		-- ●主人→敵
TargetPriority[TP_Fr2En]	= 7			-- ●友達→敵
TargetPriority[TP_Rec]		= 3			-- ●平均戦闘時間
TargetPriority[TP_Rank]		= 4			-- ●設定優先度
TargetPriority[TP_Dist]		= 5			-- ●主人からの距離
-------------------------------------
-- FriendPriority配列
-- Aが攻撃側、Dが被弾側
-- 重視したい職IDの要素に倍率を入れる
-------------------------------------
FriendPriorityA				= {}
FriendPriorityD				= {}
------------------------------------
--敵情報管理配列
------------------------------------
eInfo						= {}
------------------------------------
--スキル倍率変動用配列
------------------------------------
ASP_MagniT = {1, 1, 1, 1, 1, 1, 1, 1, 1}

-- スキル定義作成 ----------------------------------------------------------------------------------------------------
SkillDefine(MyID)

-- 外部ファイル読み込み・調整
-- 友達リストファイル読み込み ---------------------------------------------------------------------------------------------------------
IncludeFiles(SaveDir.."Friend", ".lua")

FriendIndex	= TableSize(FriendList)					-- 友達リストの番号
FriendIndex	= FriendIndex + CheckHomFriend()						-- ホム友達チェック
-- 外部設定ファイル読み込み ---------------------------------------------------------------------------------------------------------
if IncludeFiles(SaveDir.."Set", ".lua") then
	Setting()
	--TraceAI(" ! ReadFile : "..setFile)
end
-- 設定ファイル読み込み後の再定義 ----------------------------------------------------------------------------------------------------
OBD_Neutral				= OnBattleDistance	-- 初期値を記憶
AD_Neutral				= AttackDistance

if IncludeFiles(SaveDir.."CustomCommand", ".lua") then
	CustomCommand = true
end
-- Mob別設定配列の作成 ----------------------------------------------------------------------------------------------------
Mob = {}				-- 配列設定

--スキルの詳細設定
SkillSetting()

InitializedTime			= GetTick()
InitialFlag				= false

--TraceAI("----- Initialized ----- ")
end
-- 設定変数ここまで -----------------------------------------------------------------------------------------------
-------------------------------------------------
-- GetV用定数
-------------------------------------------------
--------------------------------
V_OWNER				=	0		-- 召喚者の ID
V_POSITION			=	1		-- 座標 (x、y) 
V_TYPE				=	2		-- タイプ (未実装) 
V_MOTION			=	3		-- 現在の命令 
V_ATTACKRANGE		=	4		-- 物理攻撃範囲 (未実装。現在は1セルに固定)
V_TARGET			=	5		-- 攻撃、スキル使用対象の ID 
V_SKILLATTACKRANGE	=	6		-- スキル攻撃範囲 (未実装)
V_HOMUNTYPE			=	7		-- ホムンクルスの種類
V_HP				=	8		-- HP (ホムンクルスと召喚者)
V_SP				=	9		-- SP (ホムンクルスと召喚者)
V_MAXHP				=	10		-- 最大 HP (ホムンクルスと召喚者)
V_MAXSP				=	11		-- 最大 SP (ホムンクルスと召喚者)
V_MERTYPE			=	12		-- 傭兵の種類
V_POSITION_APPLY_SKILLATTACKRANGE = 13		-- 射程判定？
V_SKILLATTACKRANGE_LEVEL = 14				-- スキルの射程を返す
---------------------------------

-- 傭兵実装まで緊急対応
GetVS = GetV
function GetV(COM,id)
	if COM == V_MERTYPE then
		return -1
	else
		return GetVS(COM,id)
	end
end

--------------------------------------------
-- ホムンクルスの種類 
--------------------------------------------
LIF					= 1
AMISTR				= 2
FILIR				= 3
VANILMIRTH			= 4
LIF2				= 5
AMISTR2				= 6
FILIR2				= 7
VANILMIRTH2			= 8
LIF_H				= 9
AMISTR_H			= 10
FILIR_H				= 11
VANILMIRTH_H		= 12
LIF_H2				= 13
AMISTR_H2			= 14
FILIR_H2			= 15
VANILMIRTH_H2		= 16
-- ホムS
EIRA				= 48
BAYERI				= 49
SERA				= 50
DIETER				= 51
ELEANOR				= 52
-- ホムS全般
HOMU_S				= 999

--------------------------------------------
--------------------------------------------
-- 傭兵 種類 
--------------------------------------------
ARCHER01	= 1
ARCHER02	= 2
ARCHER03	= 3
ARCHER04	= 4
ARCHER05	= 5
ARCHER06	= 6
ARCHER07	= 7
ARCHER08	= 8
ARCHER09	= 9
ARCHER10	= 10
LANCER01	= 11
LANCER02	= 12
LANCER03	= 13
LANCER04	= 14
LANCER05	= 15
LANCER06	= 16
LANCER07	= 17
LANCER08	= 18
LANCER09	= 19
LANCER10	= 20
SWORDMAN01	= 21
SWORDMAN02	= 22
SWORDMAN03	= 23
SWORDMAN04	= 24
SWORDMAN05	= 25
SWORDMAN06	= 26
SWORDMAN07	= 27
SWORDMAN08	= 28
SWORDMAN09	= 29
SWORDMAN10	= 30
--------------------------------------------
--------------------------
-- コマンド定数
--------------------------
NONE_CMD			= 0
MOVE_CMD			= 1
STOP_CMD			= 2
ATTACK_OBJECT_CMD	= 3
ATTACK_AREA_CMD		= 4
PATROL_CMD			= 5
HOLD_CMD			= 6
SKILL_OBJECT_CMD	= 7
SKILL_AREA_CMD		= 8
FOLLOW_CMD			= 9
--------------------------
-----------------------------
-- 状態定数
-----------------------------
IDLE_ST						= 0
FOLLOW_ST					= 1
CHASE_ST					= 2
ATTACK_ST					= 3
MOVE_CMD_ST					= 4
STOP_CMD_ST					= 5
ATTACK_OBJECT_CMD_ST		= 6
ATTACK_AREA_CMD_ST			= 7
PATROL_CMD_ST				= 8
HOLD_CMD_ST					= 9
SKILL_OBJECT_CMD_ST			= 10
SKILL_AREA_CMD_ST			= 11
FOLLOW_CMD_ST				= 12
FOLLOW_CMD_MOVE_ST			= 13
-- 追加状態定数
HOOK_ST					= 24			-- フック中状態定数
ESCAPE_ST				= 25			-- 逃避行動状態の状態定数
SHOOTING_ST				= 26			-- 状態変数
ALERT_ST				= 27			-- アラートパフォーマンス用
FORWARD_ST				= 28			-- 先導状態定数
SEARCH_ST				= 29			-- 探索状態定数
SLEEP_ST				= 30			-- 睡眠
----------------------------
--------------------------
-- motion
--------------------------
MOTION_STAND			= 0				-- 立っているモーション（動作）
MOTION_MOVE				= 1				-- 移動中のモーション
MOTION_ATTACK			= 2				-- 攻撃中のモーション
MOTION_DEAD				= 3				-- 死んで倒れるモーション
MOTION_DAMAGE			= 4				-- ダメージを受けた時のモーション
MOTION_PICKUP			= 5				-- 拾うモーション
MOTION_SIT				= 6				-- 座るモーション
MOTION_SKILL			= 7				-- スキル攻撃中モーション（インベ、カートレボリューション、ラウドボイス確認）
MOTION_CASTING			= 8				-- 詠唱モーション
MOTION_ATTACK2			= 9				-- 攻撃モーション
MOTION_SPIRAL			= 11			-- スパイラルピアース
MOTION_TOSS				= 12			-- 投げ（ポーションピッチャー）のモーション
MOTION_COUNTER			= 13			-- カウンターモーション
MOTION_RECITAL			= 17			-- 演奏モーション
MOTION_SOUL				= 23			-- 魂モーション
MOTION_BIGTOSS			= 28			-- スリムポーションピッチャー&ADSのモーション
MOTION_NINJUTSU			= 35			-- 忍術（火炎陣、畳返し）
MOTION_GUN				= 38			-- 銃撃モーション
MOTION_FLIP_COIN		= 39			-- フリップザコイン
MOTION_GUN2				= 42			-- 銃撃モーション2

--------------------------
------------------------------------------
-- グローバル変数(オリジナル）
------------------------------------------
MyState				= IDLE_ST		-- 最初の状態は待機
MyEnemy				= 0				-- 敵 id
MyDestX				= 0				-- 目的地 x座標
MyDestY				= 0				-- 目的地 y座標
MyID				= 0				-- ホムンクルス id
------------------------------------------
-- MobRec用グローバル定数 ------------------------------------------------------------------------------------------------
-- Mob[ID][value]   value:ACT, SKILL, CAST, SKILLT, RANK, RECORD
M_ACT					= 1				-- Mobに対する振る舞い
ACT_ESCAPE				= 0				-- ├逃げる
ACT_NO					= 1				-- ├一切何もしない
ACT_IGNORE				= 2				-- ├無視する（主人等のターゲットは攻撃）
ACT_NORMAL				= 3				-- ├通常
ACT_RAID				= 4				-- └先制攻撃
M_SKILL					= 2				-- スキルに関して
SKILL_NO				= 0				-- ├攻撃系スキルを使わない
SKILL_AUTO				= 6				-- ├スキルを使う（デフォルト設定）
SKILL_FULL_AUTO			= 12			-- └フルフラット（オートレベル）
M_AS					= 3				-- オートスキルの個別基本確率設定
M_CAST					= 4				-- 詠唱妨害
CAST_OFF				= 0				-- ├しない
CAST_ON					= 1				-- └する
M_SKILLT				= 5				-- スキルテーブルについて
SKILLT_DEFAULT			= 0				-- ├デフォルト設定
SKILLT_MAXNUM			= 5				-- └テーブル数
M_RANK					= 6				-- 個別索敵優先度
M_RECORD				= 7				-- 平均戦闘時間用
M_SKILLC				= 8				-- スキル使用回数

-- EditControl用グローバル定数 ------------------------------------------------------------------------------------------------
-- 割り当て用操作ごとに定数
EDIT_NONE				= 0				-- なにもしない
EDIT_FRIEND				= 1				-- 友達登録操作
EDIT_SKILL				= 2				-- スキル使用可否操作
EDIT_SKILL_LEVEL		= 3				-- スキルレベル登録操作
EDIT_IGNORE				= 4				-- 無視設定登録操作
EDIT_RAID				= 5				-- 先制攻撃登録操作
EDIT_SKILLT				= 6				-- スキルテーブル対象登録操作
EDIT_CAST				= 7				-- 詠唱妨害対象登録操作
EDIT_RANK				= 8				-- 優先度増加操作
EDIT_BONUS				= 9				-- 手加減対象登録操作
EDIT_FULL_SKILL			= 10			-- フルスキル対象登録操作
EDIT_FRIEND_ALL			= 11			-- 画面内全員友達登録操作
EDIT_FRIEND_DEL			= 12			-- 友達リスト全削除操作

-- TriggerControl用グローバル定数 ------------------------------------------------------------------------------------------------
T_FLAG					= {}			-- フラグ管理
TRIGGER_ON				= 100			-- トリガーON
TRIGGER_OFF				= 101			-- トリガーOFF
TRIGGER_PING			= 102			-- 単発条件
TRIGGER_OnESCAPE		= 1				-- 退避状態化
TRIGGER_OnSEARCH		= 2				-- サーチング
TRIGGER_OnFORWARD		= 3				-- 先行移動化
TRIGGER_OnSHOOTING		= 4				-- 援護射撃化
TRIGGER_ACTIVE			= 5				-- アクティブ化
TRIGGER_CHANGE_OWNER	= 6				-- オーナーチェンジ
TRIGGER_ASP_INC			= 7				-- AS時の確率増加
TRIGGER_ASL_INC			= 8				-- AS時のレベル増加
TRIGGER_OnMOVE			= 9				-- 指定座標へ移動
TRIGGER_CHANGE_MODE		= 10			-- モードチェンジ
TRIGGER_PRIORITY_oENEMY	= 11			-- 主人の敵優先
TRIGGER_PRIORITY_mENEMY	= 12			-- 自分の敵優先
TRIGGER_ASP_DEC			= 13			-- AS時の確率低下
TRIGGER_ASL_DEC			= 14			-- AS時のレベル低下
TRIGGER_FOLLOW_CMD_ST	= 15			-- 休息状態に切り替え

-- TargetPriority用定数 ------------------------------------------------------------------------------------------------
TargetPriority				= {}
TP_En2Ow		= 1
TP_En2Me		= 2
TP_En2Fr		= 3
TP_Ow2En		= 4
TP_Fr2En		= 5
TP_Rec			= 6
TP_Rank			= 7
TP_Dist			= 8
SkillObjectL = SkillObject
-- Util.luaと同等の内容--------------------------------------------------------------------------------------------
function GetDistance(x1,y1,x2,y2)
	return math.floor(math.sqrt((x1-x2)^2+(y1-y2)^2))
end
function GetDistance2(id1, id2)
	local x1, y1 = GetV(V_POSITION,id1)
	local x2, y2 = GetV(V_POSITION,id2)
	if (x1 == -1 or x2 == -1) then
		return -1
	end
	return GetDistance(x1,y1,x2,y2)
end
function IsOutOfSight(id1,id2)
	local x1,y1 = GetV (V_POSITION,id1)
	local x2,y2 = GetV (V_POSITION,id2)
	if (x1 == -1 or x2 == -1) then
		return true
	end
	local d = GetDistance (x1,y1,x2,y2)
	if d > 20 then
		return true
	else
		return false
	end
end
-- 距離関数追加--------------------------------------------------------------------------------------------
-- 四角範囲の距離 引数2つ：ID同士　引数4つ：座標同士
function GetSqDistance(p1, p2, p3, p4)
	local x1, y1 = p1, p2
	local x2, y2 = p3, p4
	if not p3 or not p4 then
		x1, y1 = GetV(V_POSITION,p1)
		x2, y2 = GetV(V_POSITION,p2)
	end
	if (x1 == -1 or x2 == -1) then
		return -1
	end
	local dx = MathABS(x1 - x2)
	local dy = MathABS(y1 - y2)
	if dx > dy then
		return dx
	else
		return dy
	end
end

----------------------------------------------------------
-- IsMonsterオーバーロード
----------------------------------------------------------
IsMonsterL = IsMonster
function IsMonster(id)
	if IsMonsterL(id) == 1 and IsHomunculus(id) == 0 and GetV(V_MOTION,id) ~= MOTION_DEAD then	--攻撃可能かつホムではない
		return 1
	else
		return 0
	end
end


-- ------------------------------------------------------ --
-- Mob.luaをロードする
-- ------------------------------------------------------ --
function LoadRecord(file)
	if not file then file = "Mob" end
	local filereqire = SaveDir..file
	local fileext = ".lua"
	local filename = filereqire..fileext
	local oldfilename = SaveDir..file..".ini"
	local fp = io.open(filename,"r")				-- ファイルを開く
	local index = 1000								-- MobのIDは1000から
	
	if (fp ~= nil) then
		IncludeFiles (filereqire, fileext)
		--TraceAI(" ! ReadFile : "..filename)
		fp:close()
	else							-- ファイルが無い場合は新規作成
		--TraceAI(" NewFile "..filename)
		fp = io.open(oldfilename,"r")				-- 旧ファイルからのコンバート
		while index < 4000 do
			index = index + 1
-- Mob配列のルールメモ：[1]Mobに対する反応 [2]スキル使用判断 [3]AS個別基本確率 [4]詠唱妨害判断 [5]特殊強化判断 [6]敵優先度 [7]平均戦闘時間
			Mob[index] = {3,6,0,0,0,0,0,0,0}
			if fp then
				local line = fp:read()
				local p = 0
				if line then
					for n in string.gfind(line, "%d+") do
						p = p + 1
						if tonumber(n) then
							Mob[index][p] = tonumber(n)
						else
							Mob[index][p] = 0
						end
					end
				end
			end
			if (1078 <= index and index <= 1085) or (2042 <= index and index <= 2046) then		-- 草キノコデコイ
				Mob[index][M_ACT] = ACT_IGNORE			-- 非反撃の値を入れる
				Mob[index][M_SKILL] = SKILL_NO			-- スキル使わない
			elseif index == 1555 or index == 1575 or index == 1579 or index == 1589 or index == 1590 then		--プラント
				Mob[index][M_ACT] = ACT_NO				-- 無視の値を入れる
			elseif index == 2158 or index == 2159 or index == 2160 then		--サモンレギオン
				Mob[index][M_ACT] = ACT_NO				-- 無視の値を入れる
			end
		end
		SaveRecord(MobFilename)
	end
	
	-- 一応PC分のIDも入れておく
	index = 0
	while index <= 30 do
		Mob[index] = {3,6,0,0,0,0,0,0,0}
		index = index + 1
	end
	index = 4001
	while index <= 4100 do
		Mob[index] = {3,6,0,0,0,0,0,0,0}
		index = index + 1
	end	
end

----------------------------------------------------------
-- Mob.luaをセーブする
----------------------------------------------------------
function SaveRecord(file)

	local filename = SaveDir..file..".lua"
	local fp
	fp = io.open(filename,"w")
	if (fp ~= nil) then
		for i,v in pairs(Mob) do
			if not v[1] then v[1] = 3 end
			if not v[2] then v[2] = 6 end
			if not v[3] then v[3] = 0 end
			if not v[4] then v[4] = 0 end
			if not v[5] then v[5] = 0 end
			if not v[6] then v[6] = 0 end
			if not v[7] then v[7] = 0 end
			if not v[8] then v[8] = 0 end
			
			if v[1]~=3 or v[2]~=6 or v[3]~=0 or v[4]~=0 or v[5]~=0 or v[6]~=0 or v[7]~=0 or v[8]~=0 then
				fp:write(string.format("Mob[%d]={ ",i))	
				fp:write(string.format("%d , %d , %d , %d , %d , %d , %d , %d }\n",v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8]))		-- 書き込み
			end
		end
		fp:close()
		--TraceAI(" ! Save Record : "..filename)
	end
end

----------------------------------------------------------
-- 友達リストをセーブする
----------------------------------------------------------
function SaveFriend()

	local filename = SaveDir.."Friend.lua"
	local fp = io.open(filename,"w")

	if (fp ~= nil) then							-- ファイルが既にあれば
		for i,v in pairs (FriendList) do
			fp:write(string.format("FriendList[%d]=%d\n",i, v))	-- 一行ずつ書き出し
		end
		for i,v in pairs (HomFriendList) do		-- ホム友達リストは
			if IsInSight(i) == 1 then			-- 画面内に居れば
				fp:write(string.format("HomFriendList[%d]=%d\n",i, v))	-- 一行ずつ書き出し
			end
		end
		fp:close()
	end
	--TraceAI(" ! Save File : "..filename)
end
----------------------------------------------------------
-- 関連ファイルをチェックしてインクルードする
----------------------------------------------------------
function IncludeFiles(filepath, ext)
	if io.open(filepath..ext) then
		-- requireは拡張子を取る
		local ok,err = pcall(require ,filepath)
		--TraceAI(" ! ReadFile : "..friendFile)
		if ok then			-- 正常にインクルード
			TraceAI("filepath:"..filepath..ext.."  require file:"..filepath)
			return true
		else
			ErrorOut("Error.txt", err)
			return false
		end
	end
	return false
end
-- ////////////////////////////////////////// 配列操作関数 ////////////////////////////////////////// --
----------------------------------------------------------
-- テーブルのサイズを返す
----------------------------------------------------------
function TableSize(list)
	local num = 0
	for i,v in pairs (list) do
		num = num + 1
	end	
	return num
end
----------------------------------------------------------
-- テーブルを検索してインデックスを返す
----------------------------------------------------------
function TableSearch(list,val)
	for i,v in pairs (list) do
		if val == v then		--存在したらインデックスを返す（1以上）
			return i
		end
	end	
	return 0		-- 無ければ0
end
----------------------------------------------------------
-- テーブルにinsert
----------------------------------------------------------
function TableIns(list,val,index)
	local array = {}
	local ad = index
	local pos = 0
	if not ad or ad < 1 then
		ad = TableSize(list) + 1
		list[ad] = val
		return list
	end
	for i,v in ipairs (list) do
		if i == ad then
			array[i+pos] = val
			pos = 1
		end
		array[i+pos] = v
	end	
	return array
end
----------------------------------------------------------
-- テーブルからremove
----------------------------------------------------------
function TableRem(list,index)
	local array = {}
	local ad = index
	local pos = 0
	if not ad or ad < 1 then	-- indexがない場合はPOP
		ad = TableSize(list)
		list[ad] = nil
		return list
	end
	for i,v in ipairs (list) do		--ある場合は指定のインデックスを消して詰める
		if i == ad then
			array[i+pos] = nil
			pos = -1
			TraceAI("( rem table ) index:"..i.."  val:"..v)
		else
			array[i+pos] = v
		end
	end	
	return array
end

-- ////////////////////////////////////////// 数字操作関数 ////////////////////////////////////////// --
----------------------------------------------------------
-- 絶対値
----------------------------------------------------------
function MathABS(n)
	if n < 0 then return -1*n
	else return n end
end
----------------------------------------------------------
-- 正負逆転
----------------------------------------------------------
function MathI(n)
	if n then return -1*n end
end
----------------------------------------------------------
-- 剰余 n%t
----------------------------------------------------------
function MathMod(n,t)
	if not n or not t then return 0 end
	return (n - math.floor(n/t)*t)
end
----------------------------------------------------------
-- 閾値で数を区切る n-t
----------------------------------------------------------
function MathThreshold(n,t)
	if not n or not t then return 0 end
	if n <= t then
		return n
	else
		return n - t
	end
end
----------------------------------------------------------
-- 四捨五入
----------------------------------------------------------
function MathRound(n)
	return math.floor(n + 0.5)
end 

-- ////////////////////////////////////////// 判定系関数 ////////////////////////////////////////// --

-------------------------------------------------------------------------------------
--  対象がプレイヤーであるかどうかを確かめる関数
-------------------------------------------------------------------------------------
function IsPlayer (id)
	if id < 100000 then			-- id 100000以下はMob
		return 0
	else
		return 1
	end
end

-------------------------------------------------------------------------------------
-- 対象が友達であるかどうかを確かめる関数
-------------------------------------------------------------------------------------
function IsFriend(id)
	if id >= 100000 then								-- idが100000以上ならプレイヤー
		if FriendList[id] then
			local job = GetV(V_HOMUNTYPE,id)
			if FriendList[id] ~= job then
				FriendList[id] = job
				TraceAI(id.." changed character to "..job)
			end
			return 1
		end
	else												-- それ以下ならホムか傭兵
		if HomFriendList[id] == GetV(V_HOMUNTYPE,id) and IsHomunculus(id) == 1 then
			return 1
		elseif HomFriendList[id] == GetV(V_MERTYPE,id) and IsMercenary(id) == 1 then
			return 1
		end
	end	
	return 0										-- 無ければ0を返す
end

-------------------------------------------------------------------------------------
--  対象がホムンクルスであるかどうかを確かめる関数
-------------------------------------------------------------------------------------
function IsHomunculus(id)
	if id >= 100000 then			-- id 100000以上はプレイヤー
		return 0
	end	
	id = GetV(V_HOMUNTYPE,id)
	if (id >=1 and id <= 16) or (id >= 48 and id <= 52) then
		return 1
	else
		return 0
	end
end

-------------------------------------------------------------------------------------
--  対象が傭兵であるかどうかを確かめる関数
-------------------------------------------------------------------------------------
function IsMercenary(id)
	if id >= 100000 then			-- id 100000以上はプレイヤー
		return 0
	end	
	id = GetV(V_MERTYPE,id)
	if id >=1 and id <= 30 then
		return 1
	else
		return 0
	end
end
-------------------------------------------------------------------------------------
--  対象が他人プレイヤーであるかどうかを確かめる関数
-------------------------------------------------------------------------------------
function IsOther(id)
	if id == 0 then			-- 0は0を返す
		return 0
	end
	if id ~= MyID and id ~= MyOwner and IsFriend(id) == 0 then		-- 自分でも他人でも友達でもない
		return 1
	else
		return 0
	end
end

-------------------------------------------------------------------------------------
-- Mobかどうかの判定
-------------------------------------------------------------------------------------
function IsMob(id)
	local t = GetV(V_HOMUNTYPE,id)
	if id < 100000 and t >= 1001 then		-- idが10万未満で、種族IDが1001以上
		return 1
	else
		return 0
	end
end

-------------------------------------------------------------------------------------
-- 対象が画面内に存在するかどうかを確かめる関数
-- 存在する→1が返る　存在しない→0が返る
-------------------------------------------------------------------------------------
function IsInSight(id)
	local ac = GetActors()
	for i,actor in ipairs(ac) do
		if actor == id then
			return 1
		end
	end
	return 0				-- 画面内にidが居れば1、なければ0
end

-------------------------------------------------------------------------------------
-- 対象同士が同セル上かどうかを確かめる関数
-- 同セル→1が返る　同セルではない→0が返る
-------------------------------------------------------------------------------------
function IsSamePos(id1,id2)
	local x1,y1 = GetV(V_POSITION,id1)
	local x2,y2 = GetV(V_POSITION,id2)
	if x1 == x2 and y1 == y2 then
		return 1
	end
	return 0				-- 画面内にidが居れば1、なければ0
end
-------------------------------------------------------------------------------------
-- 対象が植物であるかどうかを確かめる関数 草キノコ→1 その他→0
-------------------------------------------------------------------------------------
function IsPlant(id)
	id = GetV(V_HOMUNTYPE,id)
	if 1078 <= id and id <= 1085 then
		return 1
	else
		return 0
	end
end
-------------------------------------------------------------------------------------
-- 対象がデコイであるかどうかを確かめる関数 デコイ→1 その他→0
-------------------------------------------------------------------------------------
function IsDecoy(id)
	id = GetV(V_HOMUNTYPE,id)
	if 2042 <= id and id <= 2046 then
		return 1
	else
		return 0
	end
end
-------------------------------------------------------------------------------------
-- 対象がレギオンであるかどうかを確かめる関数 レギオン→1 その他→0
-------------------------------------------------------------------------------------
function IsRegion(id)
	id = GetV(V_HOMUNTYPE,id)
	if 2158 <= id and id <= 2160 then
		return 1
	else
		return 0
	end
end

--------------------------------------------------------------------------------------
--  横殴り防止関数  idのターゲットが自分、主人、友達のどれかであればtrueが返る
--------------------------------------------------------------------------------------
function IsNotNoManner(myid, id, active)
	local target = ActorInfo(id,"target")		-- ターゲットのターゲット
	local ans = false
	
	if not ActorInfo(id,"targetable") then				-- ターゲット不可フラグがついてたら
		return false
	end
	
	if target == 0 or ( target == myid or target == GetV(V_OWNER, myid)  or IsFriend(target) == 1) then
		ans = true
	elseif target < 100000 then				-- idのターゲットが他Mobなら
		if Actors[target] then						-- オブジェクトがあって
			if Actors[target].type > 1000 then		-- Mob相手ならば
				ans = true
			elseif Actors[target].timestamp < GetTick() then						-- idのターゲットのタイムスタンプが非更新=ターゲットが画面外ならtrue
				ans = true
			end
			-- オブジェクトがあってそれ以外の条件はターゲット不可
		else
			ans = true			-- オブジェクトがなければターゲット可
		end
	--elseif IsInSight(100000-id) == 1 then										-- 同IDの死体が画面内にあったら
		--ans = false
	end
	
	if OthersCount > 0 and active then
		-- ターゲット周囲のプレイヤーチェック
		local players = GetInRangeActors(Others, id, OthersRange)				-- ターゲットした敵の周囲のオブジェクト
		if players[1] then
			ans = false
		end
		
		--移動方向チェック
		local tstep = Actors[id].step
		local tx,ty = VectorCheck(tstep.x1,tstep.y1,Actors[id].posx,Actors[id].posy)
		for i,v in pairs(Others) do
			--距離が近い
			if GetDistance2(v,id) <= OthersRange then
				return false
			end
			--他人とターゲットのベクトル
			local otx,oty = VectorCheck(Actors[id].posx,Actors[id].posy,Actors[i].posx,Actors[i].posy,1)
			if tx == otx and ty == oty then
				Actors[id].keeptime = GetTick() + 2000		-- キープタイム追加
				return false
			end
		end
	end
	
	
	return ans
end

-------------------------------------------------------------------------------------
-- 攻撃・スキル・詠唱のモーションであるかどうか
-------------------------------------------------------------------------------------
function IsActiveMotion(id)
	local m = GetV(V_MOTION,id)
	if m == MOTION_ATTACK or m == MOTION_ATTACK2 or m == MOTION_CASTING or m == MOTION_SKILL then
		return 1
	elseif m == MOTION_GUN or m == MOTION_GUN2 or m == MOTION_SPIRAL or m == MOTION_TOSS or m == MOTION_BIGTOSS then
		return 1
	end
	return 0
end
-------------------------------------------------------------------------------------
-- ケミ系列であるかどうか
-------------------------------------------------------------------------------------
function IsAlchemist(v)
	local j = GetV(V_HOMUNTYPE,v)
	if v > 100000 then
		if j == 18 or j == 4019 or j == 4041 or j == 4071 or j == 4079 then
			return 1
		end
	end
	return 0
end

-------------------------------------------------------------------------
-- 配列の中から該当の番号を探す
-------------------------------------------------------------------------
function IsSearch(objects,id)
	for i,v in pairs(objects) do
		if v == 0 then
			return 0
		elseif v == id then
			return 1
		end
	end
	return 0
end


-------------------------------------------------------
-- 旋回ダンスに関する定義
-------------------------------------------------------
function Rondo(pattern,radius)
	local mx, my = GetV(V_POSITION,MyID)
	local turnFlag = false
	if PatrolVector == 0 then
		SetRondo(pattern,radius)
		Rdx,Rdy = mx,my
		PatrolVector = 1
	end
	if StepDelay > 0 then
		turnFlag = false
	elseif (Rdx == mx and Rdy == my) then
		turnFlag = true
	end
	if turnFlag or MoveDelay+StepDelay < GetTick() then			-- 目標地点に到達したか，移動ディレイが経過した
		if PatrolVector <= VectorEnd then
			NowRondo = true
			Rdx,Rdy = rondDist[PatrolVector].x,rondDist[PatrolVector].y
			Move (MyID,rondDist[PatrolVector].x,rondDist[PatrolVector].y)
			MoveDelay = MoveSpeed*GetDistance(mx,my,rondDist[PatrolVector].x,rondDist[PatrolVector].y)		-- 移動時間計算
			MoveDelay = GetTick() + MoveDelay
		else
			PatrolVector = 0
			NowRondo = false
			RondEnd = os.time()
			if PatrolInterval == 0 then
				Rondo(RondoPattern,RondoRadius)
			end
			return
		end
		PatrolVector = PatrolVector +1
	end
end

function SetRondo(pattern,radius)
	NowX, NowY = GetV (V_POSITION,MyID)		-- 座標取得
	MoveSpeed = 150							-- くるくる速度係数
	rondDist = {}
	local sub =  math.floor(radius*2/3)
	local ox,oy = Actors[MyOwner].posx,Actors[MyOwner].posy
	if pattern == 1 then		-- その場で旋回
		rondDist = {{x=NowX-radius,y=NowY+radius},{x=NowX,y=NowY+radius*2},{x=NowX+radius,y=NowY+radius},{x=NowX,y=NowY}}
		VectorEnd = 4
	elseif pattern == 2 then	-- 主人の周りを旋回（菱形）
		rondDist = {{x=ox-radius,y=oy},{x=ox,y=oy+radius},{x=ox+radius,y=oy},{x=ox,y=oy-radius}}
		VectorEnd = 4
	elseif pattern == 3 then	-- 主人の周りを旋回（正方形）
		rondDist = {{x=ox-radius,y=oy-radius},{x=ox-radius,y=oy+radius},{x=ox+radius,y=oy+radius},{x=ox+radius,y=oy-radius}}
		VectorEnd = 4
	elseif pattern == 4 then	-- 主人の座標を交点に十字
		rondDist = {{x=ox-radius,y=oy},{x=ox+radius,y=oy},{x=ox+1,y=oy},{x=ox,y=oy+1},{x=ox,y=oy+radius},{x=ox,y=oy-radius},{x=ox,y=oy-1}}
		VectorEnd = 7
	elseif pattern == 5 then	-- 主人の周りを旋回（円形）
		rondDist = {{x=ox,y=oy-radius},{x=ox-sub,y=oy-radius},{x=ox-radius,y=oy-sub},{x=ox-radius,y=oy+sub},{x=ox-sub,y=oy+radius},{x=ox+sub,y=oy+radius},{x=ox+radius,y=oy+sub},{x=ox+radius,y=oy-sub},{x=ox+sub,y=oy-radius},{x=ox,y=oy-radius}}
		VectorEnd = 10
	elseif pattern == 6 then	-- 主人の座標を中心に8の字を描く
		rondDist = {{x=ox-radius,y=oy+sub},{x=ox,y=oy+radius},{x=ox+radius,y=oy+sub},{x=ox+1,y=oy},{x=ox-radius,y=oy-sub},{x=ox,y=oy-radius},{x=ox+radius,y=oy-sub},{x=ox-1,y=oy}}
		VectorEnd = 8
	elseif pattern == 8 then	-- 範囲内をランダム
		local i = 1
		VectorEnd = 10
		while i <= VectorEnd do
			rondDist[i] = {x=ox-(radius+1)+math.random(1+radius*2),y=oy-(radius+1)+math.random(1+radius*2)}
			i = i + 1
		end
	elseif pattern == 9 then	-- アラート用
		MoveSpeed = 170
		rondDist = {{x=ox-1,y=oy},{x=ox,y=oy+1},{x=ox+1,y=oy},{x=ox,y=oy-1}}
		VectorEnd = 4
	elseif pattern == 10 then	-- サーチング用
		MoveSpeed = 170
		rondDist = {{x=MyDestX-1,y=MyDestY},{x=MyDestX,y=MyDestY+1},{x=MyDestX+1,y=MyDestY},{x=MyDestX,y=MyDestY-1}}
		VectorEnd = 4
	end
end

-------------------------------------------------------
-- MoveToNearについて定義
-- IDからDist離れた位置へ移動．Distは1か2推奨
-------------------------------------------------------
function MoveToNear (id,dist)
	
	local x,y = GetV(V_POSITION,id)
	local mx,my = GetV(V_POSITION,MyID)
	if MyState == FOLLOW_ST or MyState == FOLLOW_CMD_ST then	--追従するとき
		x,y = ShiftOwnerPoint(id)		-- 目的地シフト
	end
	if not SPR_Flag or MyState == CHASE_ST or MyState == HOOK_ST then
		if dist < 3 then
			local dx = dist
			local dy = dist
			if GetDistance2(MyID,id) > 5 then
				dx = 1
				dy = 1
			end
			if MyState == FOLLOW_ST or MyState == FOLLOW_CMD_ST then
				local MdirX,MdirY = VectorCheck(mx,my,x,y)	-- 自分から主人への方向
				local ows = Actors[MyOwner].step
				local OdirX,OdirY = VectorCheck(ows.x1,ows.y1,ows.x,ows.y)	-- 主人の方向
				if OdirX ~= 0 or OdirY ~= 0 then
					if MdirX ~= OdirX then dx = MathABS(dx-1) end
					if MdirY ~= OdirY then dy = MathABS(dy-1) end
				end
				--TraceAI("ox oy = "..OdirX.." "..OdirY.."  dx dy = "..MdirX.." "..MdirY.."   +x +y = "..dx.." "..dy)
			end
			if MathABS(x - mx) > dist then
				if x < mx then
					x = x + dx
				else
					x = x - dx
				end
			elseif MyState ~= FOLLOW_ST and MyState ~= FOLLOW_CMD_ST then
				x = mx
			end
			if MathABS(y - my) > dist then
				if y < my then
					y = y + dy
				else
					y = y - dy
				end
			elseif MyState ~= FOLLOW_ST and MyState ~= FOLLOW_CMD_ST then
				y = my
			end
			x, y = AvoidOverlapCell(MyID,MyOwner,x,y)
			Move(MyID,x,y)
		else
			if GetDistance2(MyID,id) > 4 then
				x = math.floor((x+mx)/2)
				y = math.floor((y+my)/2)
				Move(MyID,x,y)
			end
		end
		MyDestX,MyDestY = x,y
	end
end

-- 進行方向と比較して同セル回避
-- id:対象ID　dest:方向性
function AvoidOverlapCell(myid,id,x,y,dest)
	local ms = ActorInfo(myid,"step")
	local os = ActorInfo(id,"step")
	if not dest then dest = 1 end
	
	if x == os.x and y == os.y then
		if ms.x < os.x then x = x + 1 * dest else x = x - 1 * dest end
		if ms.y < os.y then y = y + 1 * dest else y = y - 1 * dest end
		TraceAI("Slide Cell x:"..os.x.." y:"..os.y.." ---> x:"..x.." y:"..y)
	end
	return x, y
end

-- オーナー追従時のポイントずらし
function ShiftOwnerPoint(owner)
	local ow = Actors[owner].step
	local ox, oy = ow.x,ow.y
	local vx, vy = VectorCheck(ow.x1,ow.y1,ow.x,ow.y)			--ベクトル
	if ToOwnerSide == 1 or ToOwnerSide == -1 then
		ox = ox + vy * ToOwnerSide
		oy = oy - vx * ToOwnerSide			-- 目的地をシフト
	end
	return ox,oy
end

-------------------------------------------------------
-- id(x,y)からrange離れた最短ポイントへ移動
-- 移動中は1、射程内に入ったら0を返す
-------------------------------------------------------
function MoveInRange(range,id,ny)
	local x,y = -1, -1
	local mx,my = Actors[MyID].posx, Actors[MyID].posy
	local r = Nilpo(range)
	if ny then		-- yがあったら座標指定
		x,y = id,ny
	else			-- なければID指定
		x = ActorInfo(id,"posx")
		y = ActorInfo(id,"posy")
	end
	--TraceAI("Range : "..r.."  x : "..x.." y : "..y)
	if x >= 0 and y >= 0  and r > 0 then
		local dx = x - mx
		local dy = y - my
		local px,py = mx,my
		
		-- x軸の射程内距離
		if dx >= r then
			px = x - r
		elseif dx <= -1*r then
			px = x + r
		end
		-- y軸の射程内距離
		if dy >= r then
			py = y - r
		elseif dy <= -1*r then
			py = y + r
		end
		if mx ~= px or my ~= py then
			TraceAI(">>>>> Move to in Range....... px : "..px.." py : "..py.." from range"..r)
			px, py = AvoidOverlapCell(MyID,MyOwner,px,py)
			Move(MyID,px,py)
			return 1
		end
		--TraceAI(">>>>> in Range !")
		return 0
	end
	return -1
end

-------------------------------------------------------
-- 移動先の位置をテンキーの数値で表現し，返す関数
-------------------------------------------------------
function InputCommand(x,y)
	local ow = Actors[GetV(V_OWNER,MyID)]
	
	if x+1 == ow.posx and y == ow.posy then						-- ←：主人の左(4)
		return 4
	elseif  x-1 == ow.posx and y == ow.posy then						-- →：主人の右(6)
		return 6
	elseif  x == ow.posx and y+1 == ow.posy then						-- ↓：主人の下(2)
		return 2
	elseif  x == ow.posx and y-1 == ow.posy then						-- ↑：主人の上(8)
		return 8
	else
		return 0
	end
end

-------------------------------------------------------****-------------------------------------------------------
-- ステップコマンドを判定，実行する関数
-------------------------------------------------------****-------------------------------------------------------
function JudgeCommand()
	-- コマンド判定開始
	if CustomCommand then	-- カスタムファイルがあるときは
		JudgeCommand2()		-- カスタムファイルのコマンドを実行
	elseif StepCommand[1] == 4 and StepCommand[2] == 6 and StepCommand[3] == 4 then				-- ←→←　で　ばくれつけんだ！
		AdditionalProb = 100
		MyState = ALERT_ST																	-- 主人の周りを旋回して合図		
	elseif StepCommand[1] == 6 and StepCommand[2] == 2 and StepCommand[3] == 6 then				-- →↓→で援護射撃モード
		--TraceAI ("--> Command Succses!! Shooting Mode")		
		ShootingMode = T2F(ShootingMode)
	elseif StepCommand[1] == 2 and StepCommand[2] == 2 and StepCommand[3] == 2 then				-- ↓↓↓でばくれつけんリセット
		--TraceAI ("--> Command Succses!! Rest")
		AdditionalProb = 0
		MyState = ALERT_ST																	-- 主人の周りを旋回して合図		
	elseif StepCommand[1] == 4 and StepCommand[2] == 4 and StepCommand[3] == 4 then				-- ←←←でSP節約
		--TraceAI ("--> Command Succses!! AutoAttackSkill OFF")
		AdditionalProb	= -100
		MyState = ALERT_ST																	-- 主人の周りを旋回して合図
	elseif StepCommand[1] == 6 and StepCommand[2] == 6 and StepCommand[3] == 6 then				-- →→→でオートスキル使用
		--TraceAI ("--> Command Succses!! AutoAttackSkill ON")
		AdditionalProb = 0
		MyState = ALERT_ST																	-- 主人の周りを旋回して合図
	elseif StepCommand[1] == 8 and StepCommand[2] == 2 and StepCommand[3] == 6 then				-- ↑↓→でマスター委譲
		--TraceAI ("--> Command Succses!! Change Owner")
		ChangeOwner()																		-- 偽主人の周りを旋回
	elseif StepCommand[1] == 4 and StepCommand[2] == 6 and StepCommand[3] == 2 then				-- ←→↓で共闘モードスイッチ
		if BonusMode then
			--TraceAI ("--> Command Succses!! BonusMode OFF")
			BonusMode = false
		else
			--TraceAI ("--> Command Succses!! BonusMode ON")
			BonusMode = true
		end
		MyState = ALERT_ST
		
	elseif StepCommand[1] == 8 and StepCommand[2] == 8 and StepCommand[3] == 8 then				-- ↑↑↑で全ての設定を初期化
		--TraceAI ("--> Command Succses!! Initialize")
		InitialFlag	= true
		MyState = ALERT_ST																		-- 主人の周りを旋回して合図
	elseif StepCommand[1] == 2 and StepCommand[2] == 4 and StepCommand[3] == 2 then				-- ↓←↓で友達リストクリア
		ClearFriendList()
	end			-- ここでコマンド判定終了
	
end

-------------------------------------------------------
-- ステップコマンドをクリアする関数
-------------------------------------------------------
function CommandClear()
	StepCommand = {0, 0, 0}
	SCIndex = 0
end

-------------------------------------------------------
-- 移動コマンドを受けた時に関する定義
-------------------------------------------------------
function OnMOVE_CMD (x,y)
	
	--TraceAI ("OnMOVE_CMD")
	--  ステップコマンド入力処理
	if GetDistance2(MyID,GetV(V_OWNER,MyID)) <= 2 then
		local command = InputCommand(x,y)
		SCIndex = SCIndex + 1
		StepCommand[SCIndex] = command
		--TraceAI (" -> Command"..SCIndex.." : "..StepCommand[SCIndex])
		if command == 0 then
			CommandClear()
		end
		if StepCommand[3] ~= 0 then
			JudgeCommand()
			CommandClear()
			return
		end
	else
		CommandClear()
	end
	local id = GetID(x,y)
	local mx, my = GetV(V_POSITION,MyID)

	if x == mx and y == my then
		TriggerControl("ALT_MY_CLICK",TRIGGER_PING,ALT_MY_CLICK)					-- トリガー：自分のセルALT+右クリック
		return
	elseif id == GetV(V_OWNER,MyID) then
		TriggerControl("ALT_OWNER_CLICK",TRIGGER_PING,ALT_OWNER_CLICK)				-- トリガー：主人のセルALT+右クリック
		return
	elseif IsFriend(id) == 1 then
		TriggerControl("ALT_FRIEND_CLICK",TRIGGER_PING,ALT_FRIEND_CLICK,id)			-- トリガー：友達のセルALT+右クリック
		return
	end

	local curX, curY = GetV (V_POSITION,MyID)
	if (MathABS(x-curX)+MathABS(y-curY) > 15) then		-- 目的地が一定距離以上なら (サーバーで遠距離は処理しないため)
		return
	end
	
	if MyState ~= MOVE_CMD_ST then
		LastState = MyState
	end
	MyState = MOVE_CMD_ST
	MyDestX = x
	MyDestY = y
end

-------------------------------------------------------
-- 通常攻撃コマンドを受けた時に関する定義
-------------------------------------------------------
function OnATTACK_OBJECT_CMD (id)

	--TraceAI ("OnATTACK_OBJECT_CMD")
	if id ~= MyEnemy then
		ResetEnemy()
	end
	local act = ActorInfo(id,"m","act")
	MyEnemy = id
	
	if GetDistance2(MyID,id) < 3 then		-- 近ければそのまま戦闘状態へ
		MyState = ATTACK_ST
	else
		MyState = CHASE_ST
	end
	eInfo.manualattack = true
	
	local o_motion = GetV(V_MOTION,GetV(V_OWNER,MyID))										-- 主人のモーション
	if o_motion ~= MOTION_SIT then												-- 座り以外なら
		EditControl(ALT_D_CLICK,id)											-- 登録操作
	else
		EditControl(ALT_D_CLICK_SIT,id)										-- 登録操作
	end
end

-------------------------------------------------------
-- 対象指定スキルコマンドを受けた時に関する定義
-------------------------------------------------------
function OnSKILL_OBJECT_CMD (level,skill,id)
	
	local enemy = GetV(V_HOMUNTYPE,id)						-- 敵の種別ID
	if skill == 8012 and LimitSBR then						-- スキルがS.B.Rだったら
		local num = TableSize(SBR_Target)
		for i,target in ipairs(SBR_Target)do
			if enemy == target then			-- リストにIDがあったら
				break										-- ループ抜ける
			elseif i == num then							-- 見つからずに最後まで来ちゃったら
				return										-- スキルを使わない
			end
		end
	else
		if MyState ~= FOLLOW_CMD_ST then
			if level == 1 then
				EditControl(ATTACKSKILL_LV1,id)
			elseif level == 2 then
				EditControl(ATTACKSKILL_LV2,id)
			end
		else
			EditControl(ALT_T_ATTACKSKILL,id,level)
		end
	end
	TraceAI ("OnSKILL_OBJECT_CMD")
	
	
	local slotid = GetSkillSlotID(skill)		-- スキル定義
	local range = Nilpo(Skills[slotid].range[level])
	--local range = GetV(V_SKILLATTACKRANGE_LEVEL, MyID, skill, level)		-- 射程
	
	if LongRangeSkill then
		if MoveInRange(range,id) == 1 then		--射程まで移動
			TraceAI("reserve!!! level : "..level.."  skill : "..skill.."  id : "..id)
			re_msg = {SKILL_OBJECT_CMD,level,skill,id}		-- 予約
			ReturnFlag = true
		else
			Skills[slotid].limitbreak = true			-- 手動の時は持続時間を無視
			GoSlotSkill(MyID,slotid,id,level)
			re_msg = {NONE_CMD}
		end
	else
		if IsMonster(id) == 1 then
			MyEnemy = id
		end
		if slotid ~= -1 then
			Skills[slotid].manualuse = level			--manualuseにレベルを入れておく
			CanselManualSkill = (function() Skills[slotid].manualuse = false end)
		end
		GoAttack()
	end
end

-------------------------------------------------------
-- 地面指定スキルコマンドを受けた時に関する定義
-------------------------------------------------------
function OnSKILL_AREA_CMD(level,skill,x, y)
	
	local slotid = GetSkillSlotID(skill)		-- スキル定義
	local range = Skills[slotid].range[level]
	--local range = GetV(V_SKILLATTACKRANGE_LEVEL, MyID, skill, level)		-- 射程
	
	if MoveInRange(range,x,y) == 1 then		--射程まで移動
		TraceAI("reserve!!! level : "..level.."  skill : "..skill.."  x : "..x.." y : "..y)
		re_msg = {SKILL_AREA_CMD,level,skill,x, y}		-- 予約
		ReturnFlag = true
	else
		GoSlotSkill(MyID,slotid,id,level,x,y)
		re_msg = {NONE_CMD}
	end
end

-------------------------------------------------------
-- 追従コマンドを受けた時に関する定義
-------------------------------------------------------
function OnFOLLOW_CMD ()

	-- 待機命令は、待機状態と休息状態を互いに転換させる
	if (MyState ~= FOLLOW_CMD_ST) then
		TriggerControl("ALT_T_TO_REST",TRIGGER_PING,ALT_T_TO_REST)
		ResetEnemy()
		MoveToNear (MyOwner,ChaseDistance)
		MyState = FOLLOW_CMD_ST
		if QuickTrigger then
			T_TriggerTime = GetTick()
		end
	else
		TriggerControl("ALT_T_TO_IDLE",TRIGGER_PING,ALT_T_TO_IDLE)	-- トリガー操作
		if GetV(V_MOTION,MyOwner) == MOTION_SIT and ActiveSwitch then
		-- 主人が座っている時のみ，アクティブ・ノンアクティブを切り替える
			ActiveFlag = T2F(ActiveFlag)
			local ox, oy = Actors[MyOwner].posx, Actors[MyOwner].posy
			if ActiveFlag then
				Move(MyID,ox,oy+1)				-- アクティブ化したら主人の北に移動で合図
			else
				Move(MyID,ox,oy-1)				-- ノンアクティブ化したら主人の南に移動で合図
			end
		else
			if GetTick() - T_TriggerTime < 500 then		-- 0.5秒以内にもう一度Alt+Tが押された場合
				ShiftMode(SettingList)
				StayFlag = false
				MyState = ALERT_ST
				return
			end
		end
		StayFlag = false
		MyState = IDLE_ST
	end
end


-------------------------------------------------------
-- コマンドを受け付けたときの処理
-------------------------------------------------------
function ProcessCommand(msg)

	if msg[1] == MOVE_CMD then
		OnMOVE_CMD (msg[2],msg[3])
		--TraceAI ("MOVE_CMD")
	elseif msg[1] == ATTACK_OBJECT_CMD then
		OnATTACK_OBJECT_CMD (msg[2])
		--TraceAI ("ATTACK_OBJECT_CMD")
	elseif msg[1] == SKILL_OBJECT_CMD then
		OnSKILL_OBJECT_CMD (msg[2],msg[3],msg[4])
		--TraceAI ("SKILL_OBJECT_CMD")
	elseif msg[1] == SKILL_AREA_CMD then
		OnSKILL_AREA_CMD (msg[2],msg[3],msg[4],msg[5])
		--TraceAI ("SKILL_OBJECT_CMD")
	elseif msg[1] == FOLLOW_CMD then
		OnFOLLOW_CMD ()
		--TraceAI ("FOLLOW_CMD")
	end
end

----------------------------------------------------------------------------------------------------------------------------------
-- アイドル中に関する定義
----------------------------------------------------------------------------------------------------------------------------------
function OnIDLE_ST()
	--TraceAI ("OnIDLE_ST")
	
	SearchFriend()				-- 周囲の友達を探す
	
	if SearchEnemy() then		-- 索敵
		return
	end
	
	local distance = GetDistance2(MyID,MyOwner)
	local motion = GetV(V_MOTION,MyOwner)
	if OnForward and motion == MOTION_MOVE then
		MyState = FORWARD_ST
		--RegionMate()		-- サモンレギオンチェック
		return
	elseif distance > FollowDistance or distance == -1 then		-- 主人の待機圏外に居る場合	
		if StayFlag or NowRondo or re_msg[1] == SKILL_OBJECT_CMD then				-- 停止フラグがあるとき
			MyState = IDLE_ST						-- その場で待機（離れても戻ってこない
			if motion == MOTION_MOVE then			-- 主人が移動したら
				StayFlag = false					-- 停滞はやめる
				NowRondo = false
			end
		else
			MyState = FOLLOW_ST
			--RegionMate()		-- サモンレギオンチェック
			--TraceAI ("IDLE_ST -> FOLLOW_ST")
			return	
		end
	end
	
	-- 待機状態の時に指定秒数毎にその場でくるりと1回転する
	if RondoFlag then
		local pass = os.difftime(os.time(),RondEnd)*1000
		-- タイマーが発動、かつホムの残りSPが一定％を越えた状態なら旋回動作
		if PatrolRest <= GetPerSP(MyID) and PatrolRest <= GetPerHP(MyID) then
			if pass >= PatrolInterval then
				Rondo(RondoPattern,RondoRadius)
			end
		end
	end
	PrintMessage(MyState,0)
end
OL_IDLE_ST = OnIDLE_ST

--------------------------------------------------------------------------------------------------------------
-- 追従移動中に関する定義
--------------------------------------------------------------------------------------------------------------
function OnFOLLOW_ST ()
	--TraceAI ("OnFOLLOW_ST")
	local d = GetDistance2(MyID,MyOwner)
	if d < (TargetDistance+AttackDistance)/2 then
		--if SearchEnemy() then		-- 索敵		※20111025負荷対策
		--	return
		--end
	end
	if d <= FollowDistance or d > 15 then		-- 主人からの距離が指定数以下のとき
		MyState = IDLE_ST							-- 待機状態にする
		NowRondo = false
		--TraceAI ("FOLLOW_ST -> IDLW_ST")
		return
	else		-- 自分のモーションが立ちか移動のとき
		if GetV(V_MOTION,MyOwner) == MOTION_MOVE then
			if UseSlotSkill(MyID,SKILL_FOLLOW) == 1 then
				--MoveDelay = GetTick() + 300
				return
			end
		end
		--if GetV(V_MOTION,MyID) == MOTION_STAND then
			if MoveDelay < GetTick() then
				MoveDelay = GetTick() + DifferentialAccuracy
				MoveToNear (MyOwner, ChaseDistance)													-- 主人に追従する
				PrintMessage(MyState,0)
				--TraceAI ("FOLLOW_ST -> FOLLOW_ST")
				return
			end
		--end
	end
end

--------------------------------------------------------------------------------------------------------------
-- 敵ターゲットをリセットする関数
--------------------------------------------------------------------------------------------------------------
function ResetEnemy()
	MyState = IDLE_ST						-- 状態を待機へ
	MyEnemy = 0								-- ターゲットを0へ
	eInfo = {}								-- eInfoリセット
	OurEnemys = {}							-- 敵リストリセット
	OurEnemysCount = 0						-- 敵の数リセット
	OverlapFlag = 0							-- セル重なり回避フラグリセット
	ResetWalk(MyID)							-- 足跡リセット
	ResetWalk(MyOwner)						-- 足跡リセット
	CanselManualSkill()						-- スキルのマニュアル使用をキャンセル
	ResetCombo()							-- コンボスキルのリセット
	RegionMate()							-- サモンレギオン対策
end

--------------------------------------------------------------------------------------------------------------
-- 索敵関数
--------------------------------------------------------------------------------------------------------------
function SearchEnemy()
	local object = GetEnemy (Enemys)										-- 敵検索
	if object ~= 0 then
		MyEnemy = object
		AST_Number = ActorInfo(MyEnemy,"m","skillt")				-- スキルテーブル選択
		if AST_Number >= SKILLT_MAXNUM then
			AST_Number = SKILLT_MAXNUM - 1
		elseif AST_Number < 0 then
			AST_Number = AS_TABLE1
		end
		RegionMate()		-- サモンレギオンチェック
		if ShootingMode then										-- 射撃状態で戦闘するなら
			MyState = SHOOTING_ST
			eInfo.onlyskill = true
			--TraceAI ("IDLE_ST -> SHOOTING_ST")
		else														-- 通常，敵を発見したら
			if GetDistance2(MyID,object) <= AttackDistance then		-- 射程内なら
				GoAttack()										-- 戦闘状態へ
			else
				MyState = CHASE_ST										-- 追跡状態へ
			end
			
			--TraceAI ("IDLE_ST -> CHASE_ST : ATTACKED_IN")
		end
		return true
	else
		return false
	end
end

--------------------------------------------------------------------------------------------------------------
-- 索敵関数
--------------------------------------------------------------------------------------------------------------
function SearchFriend()
	if FriendsCount > 0 then		-- 友達が居たら
		OnBattleDistance = OnBattleDistancePlus
	else
		OnBattleDistance = OBD_Neutral
	end
end

--------------------------------------------------------------------------------------------------------------
-- 敵追跡中に関する定義
--------------------------------------------------------------------------------------------------------------
function OnCHASE_ST ()

	--TraceAI ("OnCHASE_ST")
	-- ターゲットのデータ
	local edata = ActorInfo(MyEnemy)
	if Nilpo(eInfo.chasetime) == 0 then				-- 追跡時間計測
		eInfo.chasetime = GetTick()
		ResetWalk(MyID)				-- 足跡リセット
	end
	
	if edata == -1 or edata.motion == MOTION_DEAD or edata.motion == -1 then 	-- 死亡モーション中の敵は追跡しない
		ResetEnemy()
		return
	end
	local c_timeout = 3000
	if GetV(V_MOTION, MyID) ~= MOTION_MOVE and eInfo.chasetime + c_timeout < GetTick() then	-- スタックした時の処理 追跡時間が3秒以上で疑う
		Actors[MyEnemy].keeptime = GetTick() + 5000	-- 5秒間のターゲット不可タイム
		TraceAI(" /-----------/ KeepTime id:"..MyEnemy.."  untile:"..edata.keeptime)
		ResetEnemy()
		local cx,cy = AvoidOverlapCell(MyID,MyOwner,Actors[MyOwner].posx,Actors[MyOwner].posy)
		Move(MyID,cx,cy)	-- スタックセルから脱出	
		--TraceAI("CHASE_ST -> CHASE_ST : Detect Stuck (Reset)")
		return
	end
	
	local field = math.max(TargetDistance,OnBattleDistance)
	local range = field + AttackDistance
	if range > 14 then range = 14 end
	if GetDistance2(MyOwner,MyEnemy) > range then				-- 敵が索敵範囲外になったとき
		ResetEnemy()											-- リセットして待機状態になる
		MyState = IDLE_ST
		return
	end
	
	if GetDistance2(MyID,MyOwner) > OnBattleDistance then	-- 追跡中、指定距離以上ケミが離れた場合、スキル攻撃中でなければ追従
		ResetEnemy()
		MoveToNear(MyOwner,ChaseDistance)
		MyState = FOLLOW_ST
		return
	end
	if not eInfo.manualattack then					-- 手動攻撃命令時ではないとき
		if not IsNotNoManner(MyID, MyEnemy, eInfo.onactive) then	-- 接近中に誰かターゲットを奪われたとき
			ResetEnemy()
			return
		end
	end
	
	-- Chaseの最中にスキルを使用するケース
	if PreventEnemyCasting and GetV(V_MOTION,MyEnemy) == MOTION_CASTING and SkillDelay < GetTick() and edata.m.cast == CAST_ON then
		local shoot_skill = GetSkillFromASbyType({"ATK"},GetSqDistance(MyID, MyEnemy), PreventSkillLevel, MyEnemy)
		if GoSlotSkill(MyID,shoot_skill,MyEnemy,PreventSkillLevel) == 1 then
			TraceAI(" /// Prevent Casting !! ")
			return
		end
	elseif UseAutoSkill(MyID,MyEnemy) == 1 then		-- 移動中の強化スキル
		TraceAI(" ///Use On Chase !! ")
		return
	end
	
	local id = GetV(V_HOMUNTYPE,MyEnemy)
	-- 敵設定によってAttackDistance調整
	if MyEnemy < 100000 and edata.m.skill >= 0 and Mob[id] then
		if Mob[id][M_SKILL] then
			if Mob[id][M_SKILL] > 6 then		-- スキルのみ攻撃の場合は
				eInfo.onlyskill = true
				AttackDistance = OnBattleDistance
			else
				eInfo.onlyskill = false
				AttackDistance = AD_Neutral
			end
		end
	end
	-- フックフラグ判定 フック使用*フラグ0*フルスキルではない*ターゲットがまだ自分ではない
	if HookShot and edata.hook == 0 and not eInfo.onlyskill then
		Actors[MyEnemy].hook = 1
	end
	
	if GetDistance2(MyID, MyEnemy) <= AttackDistance then  	-- 敵が攻撃射程範囲内に来たとき
		GoAttack()								-- 攻撃に移る
		eInfo.chasetime = 0									-- 追跡時間はリセット
		--AttackFalseTime = GetTick()
		--Attack(MyID,MyEnemy)
		--TraceAI ("CHASE_ST -> ATTACK_ST : ENEMY_INATTACKSIGHT_IN")
		return
	else
		-- ※20111025負荷対策　移動コマンドは移動中は制限
		--if GetV(V_MOTION,MyID) == MOTION_STAND then
			MoveToNear(MyEnemy,1)		-- 敵の位置よりAttackDistanceだけ離れた位置へ
			if GetV(V_TARGET,MyEnemy) == MyID then edata.hook = 2 end
			--TraceAI ("CHASE_ST -> CHASE_ST : DESTCHANGED_IN")
			PrintMessage(MyState,MyEnemy,0,0,-1)
			return
		--end
	end
end


-----------------------------------------------------------------------------------------------
-- ターゲットをフックする関数
-----------------------------------------------------------------------------------------------
function OnHOOK_ST()
	local od = GetDistance2(MyOwner,MyID)
	local ed = GetDistance2(MyEnemy,MyID)
	if ed > 0 or GetV(V_MOTION,MyEnemy) ~= MOTION_DEAD then
		if Actors[MyEnemy].hooktime == 0 then
			Actors[MyEnemy].hooktime = GetTick()
		else
			if GetTick() - Actors[MyEnemy].hooktime > 4000 then			-- 4秒以上フックしてたらタイムアウト
				Actors[MyEnemy].hooktime = 0						-- フック時間リセット
				Actors[MyEnemy].hook = 2						-- フラグリセット
				GoAttack()							-- 攻撃に移る
				return
			end
		end
		if od > 1 then
			MoveToNear(MyOwner,1)
			return
		else
			if ed <= AttackDistance then			-- 敵が射程内に寄って来たら
				Actors[MyEnemy].hooktime = 0
				Actors[MyEnemy].hook = 2
				GoAttack()							-- 攻撃に移る
				return
			else
				return
			end
		end
	else
		ResetEnemy()
	end
end

------///////////////////////////////////////////////////////////////////////////////////////////////////////---------
--								自動スキル関連
------///////////////////////////////////////////////////////////////////////////////////////////////////////---------
-----------------------------------------------------------------------------------------------
-- 自動スキルレベル調整の関数
-- enemy : 敵種類ID		const : データが無かった場合に返す固定レベル値		ast:AS_thresholdの配列
-----------------------------------------------------------------------------------------------
function AdjustSkillLevel (enemy,const,ast)

	local record = Mob[enemy][M_RECORD]												-- 戦闘記録呼び出し
	local level = const
	
	if record and record ~= 0 then
		--TraceAI(" This Enemy's Record : "..record)
		if record < ast[1] then											-- 閾値1以下なら
			level = 0																-- スキル使用しない
		elseif ast[1] <= record and record < ast[2] then			-- 閾値1以上2以下なら
			level = 1																-- スキルLv1
		elseif ast[2] <= record and record < ast[3] then			-- 閾値2以上3以下なら
			level = 2																-- スキルLv2
		elseif ast[3] <= record and record < ast[4] then
			level = 3
		elseif ast[4] <= record and record < ast[5] then
			level = 4
		else
			level = 5
		end
		--TraceAI(" -+ Adjust Level !! : "..level)
		return level
	else
		return level
	end
end

-----------------------------------------------------------------------------------------------
-- 自動スキル確率調整の関数
-- id : 敵種類ID		aspList : 倍率配列		nowTime : 現在の戦闘時間
-----------------------------------------------------------------------------------------------
function VariableASP(id,aspList,nowTime)
	local m = 1
	if Nilpo(Mob[id][M_RECORD]) > 0 then
		local time = ((GetTick()-nowTime)/Mob[id][M_RECORD])*100
		if time < 25 then
			m = aspList[1]
		elseif time < 50 then
			m = aspList[2]
		elseif time < 75 then
			m = aspList[3]
		elseif time < 100 then
			m = aspList[4]
		elseif time < 125 then
			m = aspList[5]
		elseif time < 150 then
			m = aspList[6]
		elseif time < 175 then
			m = aspList[7]
		elseif time < 200 then
			m = aspList[8]
		else
			m = aspList[9]
		end
		--TraceAI("Rec : "..Mob[id][M_RECORD].."   time : "..time.."    Magni "..m)
	end
	return Nilpo(m)
end

-----------------------------------------------------------------------------------------------
-- 自動設置スキルの展開ポイント調整
-- area：スキル範囲	range：スキル射程 target : ターゲットID	list：対象になる相手リスト	max：対象の全数
-----------------------------------------------------------------------------------------------
function AdjustGroundPoint (area, range, target, list, max)
	-- まずtargetのx,y
	local ax, ay = GetV(V_POSITION,target)
	-- target、targetのターゲット、主人、自分の順番で検索し、一番多い座標で展開
	local scanObj = {target, GetV(V_TARGET, target), MyOwner, MyID}			-- スキャン対象リスト
	local scanPoint = {}						-- スキャン地点リスト
	local pp = 1
	local n_max = 0			-- 暫定MAX
	local h_area = (area -1)/2			-- スキル効果範囲の半径
	local bp = false
	for i,obj in ipairs(scanObj) do
		local ecnt = 0			--影響範囲の敵の数
		local dis_t = GetSqDistance(obj, target)		-- targetとの距離がエリア内部かどうか
		if dis_t <= h_area then						-- targetとobjの距離がスキル効果範囲（半径）以下
			for j,oe in pairs(list) do				-- objから見たOurEnemysそれぞれの距離
				-- 敵1体ずつと距離を計算
				local nd = GetSqDistance(obj, oe)
				if nd <= h_area then			-- 距離が範囲（半径）内
					ecnt = ecnt + 1
				end
				-- objがtargetのとき、area以下のoeとの中点座標を取得（スキャン地点リスト作成）
				if obj == target then
					if nd < area then		--エリア未満の距離（実質area-1以下）
						-- 中点座標を取得 どちらが座標低いかで寄せ方を変える
						local ncx, ncy = 0,0
						if Actors[target].posx < Actors[oe].posx then
							ncx = math.floor((Actors[target].posx+Actors[oe].posx)/2)
						else
							ncx = math.ceil((Actors[target].posx+Actors[oe].posx)/2)
						end
						if Actors[target].posy < Actors[oe].posy then
							ncy = math.floor((Actors[target].posy+Actors[oe].posy)/2)
						else
							ncy = math.ceil((Actors[target].posy+Actors[oe].posy)/2)
						end
						if CheckCell(GlobalMap,ncx,ncy) > 0 then		-- グローバルマップで侵入可地点ならば
							scanPoint[pp] = {x=ncx, y=ncy}			-- スキャン地点リストに追加
							pp = pp + 1
						end
					end
				end
			end
			--範囲内の敵が全てなら終わり
			if ecnt == max then
				ax, ay = GetV(V_POSITION,obj)
				bp = true
				n_max = ecnt					--最大値更新
				TraceAI("Best position ID:"..obj)
				break
			end
			-- 範囲内の敵が多ければ
			if n_max < ecnt then
				n_max = ecnt					--最大値更新
				TraceAI("More better position ID:"..obj)
				ax, ay = GetV(V_POSITION,obj)		--ポジション更新
			end
		end
	end
	-- 中点ポイントとの比較
	if pp > 1 and not bp then
		ecnt = 0
		for k,cp in ipairs(scanPoint) do
			for j,oe in pairs(list) do				-- objから見たOurEnemysそれぞれの距離
				-- 敵1体ずつと距離を計算
				local nd = GetSqDistance(cp.x, cp.y, Actors[oe].posx, Actors[oe].posy)
				if nd <= h_area then			-- 距離が範囲（半径）内
					ecnt = ecnt + 1
				end
			end
			--範囲内の敵が全てなら終わり
			if ecnt == max then
				ax, ay = cp.x, cp.y
				n_max = ecnt					--最大値更新
				break
			end
			-- 範囲内の敵が多ければ
			if n_max < ecnt then
				n_max = ecnt					--最大値更新
				ax, ay = cp.x, cp.y		--ポジション更新
			end
		end
	end
	TraceAI(" ***- Adjust GRD Skill Position X : "..ax.." Y:"..ay)
	-- ax,ayを返す
	return ax, ay, n_max
end
----------------------------------------------------------------------------------------------------------------------------------------
-- 自動スキル関数
-- ASテーブルに登録済みスキルを順番に判定し、自動使用するスキル
----------------------------------------------------------------------------------------------------------------------------------------
function UseAutoSkill(myid, target)
	-- 予約スキル
	if RSTable[1] then			-- 予約スキルがあれば
		local rs_slotid = RSTable[1]
		if UseSlotSkill(myid,rs_slotid,target) == 1 then
			RSTable = TableRem(RSTable,1)		-- 先頭のスキルを削除
			TraceAI(" --> !! UseReserveSkill")
			return 1
		end
		-- 予約タイムアウト
		if RSKeepTime > GetTick() then		-- 予約有効時間内
			-- 予約テーブルにスキルがあるうちは消化するまで抜ける
			TraceAI(" ======= Wite Reserve skill ->"..GetTick().." to "..RSKeepTime.."  waiting skill:"..Skills[rs_slotid].name)
			return 0
		else
			-- 有効時間を過ぎていたら初期化し、オートスキル判定へ
			RSTable = {}
			RSKeepTime = GetTick()
		end
	end
	-- オートスキル
	for i,s in ipairs(ASTable[AST_Number]) do
		--TraceAI("check skill slot"..i.." ID : "..s.."  name : "..Skills[s].name.." onstate:"..MyState)
		if useSkill then break end		-- このmainループで既にスキル使用済みならば抜ける
		if UseSlotSkill(myid,s,target) == 1 then
			TraceAI(" --> !! UseAutoSkill")
			return 1
		end
	end
	return 0
end

-- スロットに設定されているスキルを使用する関数
function UseSlotSkill(myid,slot,target,lv)
	if not Skills[slot] then		-- そのスロットIDが未設定なら
		--TraceAI("!-!-! undefined skill..."..slot)
		return 0
	else
		if Skills[slot]:use(myid,target,lv) == 1 then
			useSkill = slot
			return 1
		end
	end
	return 0
end
function GoSlotSkill(myid,slot,target,lv,x,y)
	if not Skills[slot] then		-- そのスロットIDが未設定なら
		--TraceAI("!-!-! undefined skill...")
		return 0
	else
		if Skills[slot]:go(myid,lv,target,x,y) == 1 then
			useSkill = slot
			return 1
		end
	end
	return 0
end

------------------------------------------------------------------------------------------------------------------------------------------------

-- スキル定義ここから

------------------------------------------------------------------------------------------------------------------------------------------------
-- スキル関数スロット設定
Skills = {}				-- スキルスロット
-- スキル優先順位定数
-- 強化スキルスロット定数：定数範囲1～10
SKILL_BUF1 = 1
SKILL_BUF2 = 2
SKILL_BUF3 = 3
SKILL_BUF4 = 4
SKILL_BUF5 = 5
SKILL_BUF6 = 6
SKILL_BUF7 = 7
SKILL_BUF8 = 8
SKILL_BUF9 = 9
SKILL_SWT1 = 201
SKILL_SWT2 = 202
SKILL_SWT3 = 203
-- 攻撃スキルスロット定数：定数範囲11～100
SKILL_ATK1 = 11
SKILL_ATK2 = 12
SKILL_ATK3 = 13
SKILL_ATK4 = 14
SKILL_ATK5 = 15
SKILL_ATK6 = 16
SKILL_ATK7 = 17
SKILL_ATK8 = 18
SKILL_ATK9 = 19
SKILL_COM1 = 31
SKILL_COM2 = 32
SKILL_COM3 = 33
SKILL_COM4 = 34
SKILL_SHOOT = 51
SKILL_BOMB = 52
-- 回復スキルスロット定数：定数範囲101～
SKILL_RES1 = 101
SKILL_RES2 = 102
SKILL_RES3 = 103
SKILL_RES4 = 104
SKILL_RES5 = 105
-- 追従中に使う場合
SKILL_FOLLOW = 1001
-- 追跡中に使う場合
SKILL_CHASE = 1002
-- スキル使用順テーブル定数
AS_TABLE1 = 0
AS_TABLE2 = 1
AS_TABLE3 = 2
AS_TABLE4 = 3
AS_TABLE5 = 4
ASTable = {}
ASTable[AS_TABLE1] = {}
ASTable[AS_TABLE2] = {}
ASTable[AS_TABLE3] = {}
ASTable[AS_TABLE4] = {}
ASTable[AS_TABLE5] = {}
--予約スキルテーブル
RSTable = {}
RSKeepTime = GetTick()

-- スキル名もしくはIDからスロットID検索
cache_ssid = {}
function GetSkillSlotID(n)
	if cache_ssid[n] then
		return cache_ssid[n]			-- キャッシュがあったらそのままID返す
	end
	for i,skill in pairs(Skills) do
		if skill.name == n or skill.id == n then		-- スキル名もしくはIDが一致したら
			cache_ssid[n] = i					-- キャッシュに保存
			return i								-- スロットID返す
		end
	end
	return -1
end

-- 現在のスキルテーブル中の特定のスキルタイプで、最初に指定されているスキルを返す
-- そのスキルがディレイ中/効果時間中のとき、次のスキルを検索
-- 遠距離攻撃探索用
function GetSkillFromASbyType(ty, range, level, target)
	--if cache_ssid[ty..AST_Number] then
	--	return cache_ssid[ty..AST_Number]			-- キャッシュがあったらそのままID返す →なしに
	--end
	local result = -1
	if not range then range=1 end
	if not level or level == 0 then level=1 elseif level >= 6 then level = 5 end
	for i,v in ipairs(ASTable[AST_Number]) do
		local ctp = CheckSkillType(ty, Skills[v].skilltype)
		if ctp and Skills[v].range[level] >= range then		-- スキルタイプが合致していて、射程内
			TraceAI("))) slot id = "..v.." type:"..ctp)
			if Skills[v]:usespanCheck(target) then				-- クールタイム内なら
				TraceAI("<>type : "..ctp.." is sat on "..v)
				--cache_ssid[ty..AST_Number] = v					-- キャッシュに保存
				return v
			else
				result = 0			-- スキルはあるけどクールタイム中
			end
		end
	end
	return result
end
-- スキルタイプをチェック
function CheckSkillType(ty_array,skilltype)
	for i,v in ipairs(ty_array) do
		if v == skilltype then
			return v
		end
	end
	return false
end

-- 予約スキルをセットする
-- 予約スキルテーブルに順に追加する
function SetReserveSkill(slotid, level)
	-- そのスロットIDのスキルがテーブルにセットされていれば予約
	if TableSearch(ASTable[AST_Number], slotid) > 0 then
		TableIns(RSTable, slotid)	-- 予約テーブルにセット
		local ct = Nilpo(Skills[slotid].charge[level])
		local rt = 6000		-- 予約上限6秒くらい
		if ct < rt then
			RSKeepTime = GetTick() + ct		-- クールタイム分追加
		else
			RSKeepTime = GetTick() + rt
		end
		return 1
	end
	return 0
end
-- 予約スキルをクリアする
function ClearReserveSkill()
	RSTable = {}
	RSKeepTime = GetTick()
end
-- スキルをスキルスロットにセットする
function SetSkillSlot(slot_define, skill_obj)
	Skills[slot_define] = skill_obj
	skill_obj.slotid = slot_define;
end

-- スキル定義：（設定ファイル読み込み後）
function SkillDefine(myid)
	-- 各スキルの定義
	-- ムーンライト
	MoonLight = AttackSkill.new("MoonLight",8009)
	--MoonLight.delay = {2200,2200,2200,2200,2200}			-- ディレイ定義 2014/3/28削除
	MoonLight.charge = {2000,2000,2000,2000,2000}			-- 再使用時間定義
	MoonLight.sp = {4, 8, 12, 16, 20}						-- 消費SP定義
	MoonLight.range = {1, 1, 1, 1, 1}
	
	-- フリットムーブ
	FleetMove = BufferSkill.new("FleetMove",8010)
	FleetMove.sp = {30, 40, 50, 60, 70}								-- 消費SP定義
	FleetMove.duration = {60000, 55000, 50000, 45000, 40000}			-- 持続時間
	FleetMove.charge = {30000,27500,25000,22500,20000}			-- 再使用時間定義
	--FleetMove.delay = {60000,75000,90000,105000,120000}				-- ディレイ定義 2014/3/28削除
	-- オーバードスピード
	OveredSpeed = BufferSkill.new("OveredSpeed",8011)
	OveredSpeed.sp = {30, 40, 50, 60, 70}								-- 消費SP定義
	OveredSpeed.duration = {60000, 55000, 50000, 45000, 40000}			-- 持続時間
	OveredSpeed.charge = {30000,27500,25000,22500,20000}			-- 再使用時間定義
	--OveredSpeed.delay = {60000,75000,90000,105000,120000}			-- ディレイ定義 2014/3/28削除
	
	--S.B.R44
	SBR44 = AttackSkill.new("SBR44",8012)			-- 定義だけ
	SBR44.sp = {1, 1, 1}								-- 消費SP定義
	
	-- カプリス
	Caprice = AttackSkill.new("Caprice",8013)
	Caprice.sp = {22, 24, 26, 28, 30}						-- 消費SP定義
	Caprice.charge = {1800,2100,2400,2700,3000}				-- 再使用時間定義
	Caprice.delay = {1000,1000,1000,1000,1000}				-- ディレイ定義
	Caprice.range = {9, 9, 9, 9, 9}				-- ディレイ定義
	Caprice.PrevAA = true								-- カプリスの自動レベル調整は強制オフにしてみる
	-- カオティックベネディクション
	ChaoticVenediction = RecoverSkill.new("ChaoticVenediction",8014)
	ChaoticVenediction.sp = {40, 40, 40, 40, 40}						-- 消費SP定義
	ChaoticVenediction.charge = {3000,3000,3000,3000,3000}				-- 再使用時間定義
	--ChaoticVenediction.delay = {2000,2000,2000,2000,2000}				-- ディレイ定義 2014/3/28削除
	ChaoticVenediction.noenemy = CV_NoEnemy								-- 敵が周囲に居ないとき発動
	ChaoticVenediction.holdedtarget = MyID							-- ターゲットは自分のみ		
	
	-- ディフェンス
	Defense = BufferSkill.new("Defense",8006)
	Defense.sp = {20, 25, 30, 35, 40}								-- 消費SP定義
	Defense.duration = {40000, 35000, 30000, 25000, 20000}			-- 持続時間
	Defense.charge = {20000, 17500, 15000, 12500, 10000}			-- 再使用時間
	-- ブラッドラスト
	BloodLust = BufferSkill.new("BloodLust",8008)
	BloodLust.sp = {120, 120, 120}								-- 消費SP定義
	BloodLust.duration = {60000, 180000, 300000}					-- 持続時間
	BloodLust.charge = {60000, 180000, 300000}					-- 再使用時間
	--BloodLust.delay = {300000, 600000, 900000}						-- ディレイ定義 2014/3/28削除
	if BloodLust.BufferLevel > 3 then			-- レベル設定調整
		BloodLust.BufferLevel = 3
	end
	
	-- 緊急回避
	UrgentEscape = AccelSkill.new("UrgentEscape",8002)
	UrgentEscape.sp = {20, 25, 30, 35, 40}								-- 消費SP定義
	UrgentEscape.duration = {40000, 35000, 30000, 25000, 20000}			-- 持続時間
	UrgentEscape.charge = {40000, 35000, 30000, 25000, 20000}			-- 再使用時間定義
	--UrgentEscape.delay = {35000, 35000, 35000, 35000, 35000}			-- ディレイ定義 2014/3/28削除
	--UrgentEscape.exclusive = "all"										-- 排他制御 2014/3/28削除
	UrgentEscape.usestate = {}
	UrgentEscape.usestate[FOLLOW_ST] = true
	UrgentEscape.usestate[FORWARD_ST] = true
	--UrgentEscape.target = MyOwner			-- ターゲットを主人
	-- メンタルチェンジ
	MentalChange = BufferSkill.new("MentalChange",8004)
	MentalChange.sp = {100, 100, 100}								-- 消費SP定義
	MentalChange.duration = {60000, 180000, 300000}			-- 持続時間定義(ミリ秒）
	MentalChange.charge = {600000, 900000, 1200000}			-- 再使用時間定義
	--MentalChange.delay = {600000, 900000, 1200000}			-- ディレイ定義 2014/3/28削除
	--MentalChange.exclusive = "all"							-- 排他制御 2014/3/28削除
	if MentalChange.BufferLevel > 3 then					-- レベル設定調整
		MentalChange.BufferLevel = 3
	end
	-- 治癒の手
	HealingHands = RecoverSkill.new("HealingHands",8001)
	HealingHands.sp = {13, 16, 19, 22, 25}						-- 消費SP定義
	HealingHands.charge = {2000,2000,2000,2000,2000}			-- 再使用時間定義
	--HealingHands.delay = {2000,2000,2000,2000,2000}			-- ディレイ定義
	HealingHands.holdedtarget = GetV(V_OWNER,MyID)			-- ターゲットは主人のみ
	HealingHands.AutoRecoverMyHP = -1						-- 自分のHPは見ない
	HealingHands.useitemcheck = true						-- 消費アイテムをチェック
	
	
	-- ホムごとにスキルスロット設定
	if CheckMyType(MyType) == FILIR or CheckMyType(MyPreType) == FILIR then
		--スロットに設置
		SetSkillSlot(SKILL_BUF1, FleetMove)
		SetSkillSlot(SKILL_BUF2, OveredSpeed)
		SetSkillSlot(SKILL_ATK1, MoonLight)
		-- 援護射撃スキルに設定
		SetSkillSlot(SKILL_SHOOT, MoonLight)
		-- ボムスキルに設定
		SetSkillSlot(SKILL_BOMB, SBR44)
		
		-- スロット順序設定
		ASTable[AS_TABLE1] = {SKILL_ATK1}
		ASTable[AS_TABLE2] = {SKILL_ATK1}
		ASTable[AS_TABLE3] = {SKILL_ATK1}
	elseif CheckMyType(MyType) == VANILMIRTH or CheckMyType(MyPreType) == VANILMIRTH then
		--スロットに設置
		SetSkillSlot(SKILL_ATK1, Caprice)
		SetSkillSlot(SKILL_RES1, ChaoticVenediction)
		-- 援護射撃スキルに設定
		SetSkillSlot(SKILL_SHOOT, Caprice)
		
		-- スロット順序設定
		ASTable[AS_TABLE1] = {SKILL_ATK1}
		ASTable[AS_TABLE2] = {SKILL_ATK1}
		ASTable[AS_TABLE3] = {SKILL_ATK1}
	elseif CheckMyType(MyType) == AMISTR or CheckMyType(MyPreType) == AMISTR then
		--スロットに設置
		SetSkillSlot(SKILL_BUF1, Defense)
		SetSkillSlot(SKILL_BUF2, BloodLust)
		-- スロット順序設定
		if CheckMyType(MyType,true) == AMISTR_H then		--進化後かどうか
			ASTable[AS_TABLE1] = {SKILL_BUF2,SKILL_BUF1}
			ASTable[AS_TABLE2] = {SKILL_BUF2,SKILL_BUF1}
			ASTable[AS_TABLE3] = {SKILL_BUF2,SKILL_BUF1}
		else
			ASTable[AS_TABLE1] = {SKILL_BUF1}
			ASTable[AS_TABLE2] = {SKILL_BUF1}
			ASTable[AS_TABLE3] = {SKILL_BUF1}
		end
	elseif CheckMyType(MyType) == LIF or CheckMyType(MyPreType) == LIF then
		--スロットに設置
		if CheckMyType(MyType,true) == LIF_H then		--進化後かどうか
			SetSkillSlot(SKILL_BUF1, MentalChange)
			SetSkillSlot(SKILL_BUF2, MentalChange)
			-- スロット順序設定
			ASTable[AS_TABLE1] = {SKILL_BUF1}
			ASTable[AS_TABLE2] = {SKILL_BUF1}
			ASTable[AS_TABLE3] = {SKILL_BUF1}
		end
		SetSkillSlot(SKILL_FOLLOW, UrgentEscape)
		SetSkillSlot(SKILL_RES1, HealingHands)
	elseif CheckMyType(MyType, true) == HOMU_S then
		-- ホムSの場合、全てのホムスキルのスロットを共通設定
		SetSkillSlot(SKILL_BUF1, FleetMove)
		SetSkillSlot(SKILL_BUF2, OveredSpeed)
		SetSkillSlot(SKILL_BUF3, MentalChange)
		SetSkillSlot(SKILL_BUF4, Defense)
		SetSkillSlot(SKILL_BUF5, BloodLust)
		
		SetSkillSlot(SKILL_ATK1, MoonLight)
		SetSkillSlot(SKILL_ATK2, Caprice)
		
		--Skills[SKILL_SHOOT] = MoonLight
		SetSkillSlot(SKILL_BOMB, SBR44)
		
		SetSkillSlot(SKILL_FOLLOW, UrgentEscape)
		SetSkillSlot(SKILL_RES1, HealingHands)
		SetSkillSlot(SKILL_RES2, ChaoticVenediction)
		
	end
	
	-- スイッチスキルは全ホム入れておく
	
	-- スタイルチェンジ
	StyleChange = SwitchSkill.new("StyleChange",8027)
	StyleChange.sp = {35, 35, 35, 35, 35}
	StyleChange.delay = {0,0,0,0,0}
	StyleChange.duration = {500,500,500,500,500}
	StyleChange.charge = {500,500,500,500,500}
	StyleChange.casting = {0,0,0,0,0}
	StyleChange.switch = false						-- 初期値OFF:グラップラースタイル
	
	SetSkillSlot(SKILL_SWT1, StyleChange)
	
	-- ホムSのスキル定義未定
	if CheckMyType(MyType) == BAYERI then
		-- シュタールホーン
		StahlHorn = AttackSkill.new("StahlHorn",8031)
		StahlHorn.sp = {40, 45, 50, 55, 60}
		StahlHorn.delay = {0,0,0,0,0}			-- ディレイ定義
		StahlHorn.charge = {1000, 1000, 1000, 1000, 1000}			-- 再使用時間定義
		StahlHorn.range = {5, 6, 7, 8, 9}
		StahlHorn.casting = {0,0,0,0,0}
		
		-- ゴールデンペルジェ
		GoldeneFerse = BufferSkill.new("GoldeneFerse",8032)
		GoldeneFerse.sp = {60, 65, 70, 75, 80}
		GoldeneFerse.duration = {30000, 45000, 60000, 75000, 90000}			-- ディレイ定義
		GoldeneFerse.charge = {30000, 45000, 60000, 75000, 90000}			-- 再使用時間定義
		GoldeneFerse.casting = {0,0,0,0,0}					-- 詠唱時間定義
		GoldeneFerse.exclusive = "AngriffsModus"			-- アングリフスモドス中は使用不可
		
		-- シュタインワンド
		SteinWand = BufferSkill.new("SteinWand",8033)
		SteinWand.sp = {80, 90, 100, 110, 120}
		SteinWand.duration = {30000, 45000, 60000, 75000, 90000}
		SteinWand.charge = {30000, 45000, 60000, 75000, 90000}
		SteinWand.casting = {0,0,0,0,0}
		
		-- ハイリエージュスタンジェ
		HeiligeStange = AttackSkill.new("HeiligeStange",8034)
		HeiligeStange.sp = {60, 68, 76, 84, 92}
		HeiligeStange.charge = {1000, 1000, 2000, 2000, 3000}			-- 再使用時間定義
		HeiligeStange.range = {9, 9, 9, 9, 9}							-- 射程定義
		HeiligeStange.area = {3, 3, 5, 5, 7}							-- 効果範囲定義
		HeiligeStange.casting = {0,0,0,0,0}
		
		-- アングリフスモドス
		AngriffsModus = BufferSkill.new("AngriffsModus",8035)
		AngriffsModus.sp = {60, 65, 70, 75, 80}
		AngriffsModus.duration = {30000, 45000, 60000, 75000, 90000}
		AngriffsModus.charge = {30000, 45000, 60000, 75000, 90000}
		AngriffsModus.casting = {0,0,0,0,0}
		AngriffsModus.exclusive = "GoldeneFerse"			-- ゴールデンフェルゼ中は使用不可
		
		-- 課題・ゴールデンフェルゼとアングリフモドスの排他制御
		-- 旧バフスキルとの重ねについて判明次第。
		
		SetSkillSlot(SKILL_BUF6, GoldeneFerse)
		SetSkillSlot(SKILL_BUF7, AngriffsModus)
		SetSkillSlot(SKILL_BUF8, SteinWand)
		SetSkillSlot(SKILL_ATK3, StahlHorn)
		SetSkillSlot(SKILL_SHOOT, StahlHorn)
		SetSkillSlot(SKILL_ATK4, HeiligeStange)
		
		
	elseif CheckMyType(MyType) == DIETER then
		-- マグマフロー
		MagmaFlow = BufferSkill.new("MagmaFlow",8039)
		MagmaFlow.sp = {34, 38, 42, 46, 50}
		MagmaFlow.duration = {60000, 60000, 60000, 60000, 60000}
		MagmaFlow.charge = {60000, 60000, 60000, 60000, 60000}
		MagmaFlow.area = {3, 3, 3, 5, 5}
		MagmaFlow.casting = {0,0,0,0,0}
		
		-- グラニティックアーマー
		GraniticArmor = BufferSkill.new("GraniticArmor",8040)
		GraniticArmor.sp = {54, 58, 62, 66, 70}
		GraniticArmor.duration = {60000, 60000, 60000, 60000, 60000}
		GraniticArmor.charge = {60000, 60000, 60000, 60000, 60000}
		GraniticArmor.casting = {0,0,0,0,0}
		
		-- ラーヴァスライド
		LavaSlide = AttackSkill.new("LavaSlide",8041)
		LavaSlide.skillfunc = "GRD"
		LavaSlide.sp = {30, 35, 40, 45, 50}
		LavaSlide.duration = {12000, 14000, 16000, 18000, 20000}
		LavaSlide.charge = {1000, 1000, 2000, 2000, 3000}
		LavaSlide.range = {7, 7, 7, 7, 7}
		LavaSlide.area = {3, 3, 5, 5, 7}
		LavaSlide.casting = {0,0,0,0,0}
		LavaSlide.hitcount = {5, 5, 5, 5, 5}
		
		-- パイロクラスティック
		Pyroclastic = BufferSkill.new("Pyroclastic",8042)
		Pyroclastic.sp = {20, 28, 36, 44, 52}
		Pyroclastic.duration = {60000, 90000, 120000, 150000, 180000}
		Pyroclastic.charge = {60000, 90000, 120000, 150000, 180000}
		Pyroclastic.casting = {0,0,0,0,0}
		
		-- ボルカニックアッシュ
		VolcanicAsh = AttackSkill.new("VolcanicAsh",8043)
		VolcanicAsh.skillfunc = "GRD"
		VolcanicAsh.sp = {60, 65, 70, 75, 80}
		VolcanicAsh.duration = {12000, 14000, 16000, 18000, 20000}
		VolcanicAsh.charge = {300000, 300000, 300000, 300000, 300000}
		VolcanicAsh.range = {7, 7, 7, 7, 7}
		VolcanicAsh.area = {3, 3, 3, 3, 3}
		VolcanicAsh.casting = {0,0,0,0,0}
		
		SetSkillSlot(SKILL_BUF6, MagmaFlow)
		SetSkillSlot(SKILL_BUF7, GraniticArmor)
		SetSkillSlot(SKILL_BUF8, Pyroclastic)
		SetSkillSlot(SKILL_ATK3, LavaSlide)
		SetSkillSlot(SKILL_ATK4, VolcanicAsh)
		
	elseif CheckMyType(MyType) == EIRA then
		-- 再生の光
		LightOfRegene = BufferSkill.new("LightOfRegene",8022)
		LightOfRegene.sp = {40, 50, 60, 70, 80}
		LightOfRegene.duration = {360000, 420000, 480000, 540000, 600000}
		LightOfRegene.charge = {360000, 420000, 480000, 540000, 600000}
		LightOfRegene.casting = {0,0,0,0,0}
		
		-- オーバードブースト
		OveredBoost = BufferSkill.new("OveredBoost",8023)
		OveredBoost.sp = {70, 90, 110, 130, 150}
		OveredBoost.duration = {30000, 45000, 60000, 75000, 90000}
		OveredBoost.charge = {30000, 45000, 60000, 75000, 90000}
		OveredBoost.casting = {0,0,0,0,0}
		
		-- イレイサーカッター
		EraserCutter = AttackSkill.new("EraserCutter",8024)
		EraserCutter.sp = {25, 30, 35, 40, 45}
		EraserCutter.charge = {1000, 1500, 2000, 2500, 3000}
		EraserCutter.casting = {0,0,0,0,0}
		EraserCutter.range = {7, 7, 7, 7, 7}
		EraserCutter.PrevAA = true						-- イレイサーカッターの自動レベル調整は強制オフにしてみる
		
		-- ゼノスラッシャー
		XenoSlasher = AttackSkill.new("XenoSlasher",8025)
		XenoSlasher.skillfunc = "GRD"
		XenoSlasher.sp = {90, 100, 110, 120, 130}
		XenoSlasher.casting = {0,0,0,0,0}
		XenoSlasher.charge = {1000, 1000, 1000, 1000, 1000}
		XenoSlasher.range = {7, 7, 7, 7, 7}
		XenoSlasher.area = {5, 5, 7, 7, 9}
		XenoSlasher.PrevAA = true						-- ゼノスラッシャーの自動レベル調整は強制オフにしてみる
		
		-- サイレントブリーズ
		SilentBreeze = AttackSkill.new("SilentBreeze",8026)
		SilentBreeze.sp = {80, 80, 80, 80, 80}
		SilentBreeze.casting = {0,0,0,0,0}
		SilentBreeze.duration = {6000, 9000, 12000, 16000, 18000}			-- 切れ目ないようにかけなおすため -3秒
		SilentBreeze.charge = {1000, 1000, 1000, 1000, 1000}
		SilentBreeze.range = {5, 6, 7, 8, 9}
		SilentBreeze.eachtarget = true
		
		SetSkillSlot(SKILL_BUF6, OveredBoost)
		SetSkillSlot(SKILL_BUF7, LightOfRegene)
		SetSkillSlot(SKILL_ATK3, EraserCutter)
		SetSkillSlot(SKILL_SHOOT, EraserCutter)
		SetSkillSlot(SKILL_ATK4, XenoSlasher)
		SetSkillSlot(SKILL_ATK5, SilentBreeze)
		
	elseif CheckMyType(MyType) == ELEANOR then
		
		-- ソニッククロウ
		SonicClaw = AttackSkill.new("SonicClaw",8028)
		SonicClaw.sp = {20, 25, 30, 35, 40}
		SonicClaw.delay = {0,0,0,0,0}
		SonicClaw.charge = {1000, 2000, 3000, 4000, 5000}
		SonicClaw.range = {1, 1, 1, 1, 1}
		SonicClaw.combospan = 500							-- コンボ待ち時間
		SonicClaw.cancel = function (self) end
		SonicClaw.premiseskill = StyleChange
		SonicClaw.premiseswitch = true					-- ファイタースタイルをtrue
		
		
		-- シルバーベインラッシュ
		SilverveinRush = AttackSkill.new("SilverveinRush",8029)
		SilverveinRush.sp = {10, 15, 20, 25, 30}
		SilverveinRush.delay = {200,200,200,200,200}		-- スキルディレイは無いがコンボ用に設定
		SilverveinRush.skilltype = "COM"							-- コンボスキル
		SilverveinRush.combospan = 200							-- コンボ待ち時間
		SilverveinRush.precombo = SKILL_ATK3			-- SKILL_ATK3にソニッククロウが入っている想定
		SilverveinRush.range = {1, 1, 1, 1, 1}
		
		-- ミッドナイトフレンジ
		MidnightFrenzy = AttackSkill.new("MidnightFrenzy",8030)
		MidnightFrenzy.sp = {8, 16, 24, 32, 40}
		MidnightFrenzy.delay = {200,200,200,200,200}		-- スキルディレイは無いがコンボ用に設定
		MidnightFrenzy.skilltype = "COM"							-- コンボスキル
		MidnightFrenzy.combospan = 200							-- コンボ待ち時間
		MidnightFrenzy.precombo = SKILL_COM1			-- SKILL_COM1にシルバーベインラッシュが入っている想定
		MidnightFrenzy.range = {1, 1, 1, 1, 1}
		
		-- ティンダーブレーカー
		TinderBreaker = AttackSkill.new("TinderBreaker",8036)
		TinderBreaker.sp = {20, 25, 30, 35, 40}
		TinderBreaker.delay = {200,200,200,200,200}		-- スキルディレイは無いがコンボ用に設定
		TinderBreaker.charge = {2000, 3000, 4000, 5000, 6000}
		TinderBreaker.casting = {0,0,0,0,0}
		TinderBreaker.range = {3, 4, 5, 6, 7}
		TinderBreaker.combospan = 200							-- コンボ待ち時間
		TinderBreaker.cancel = function (self) end
		TinderBreaker.premiseskill = StyleChange
		TinderBreaker.premiseswitch = false					-- グラップラースタイルをfalse
		
		-- CBC
		ContinualBreakCombo = AttackSkill.new("ContinualBreakCombo",8037)
		ContinualBreakCombo.sp = {10, 20, 30, 40, 50}
		ContinualBreakCombo.delay = {200,200,200,200,200}		-- スキルディレイは無いがコンボ用に設定
		ContinualBreakCombo.skilltype = "COM"							-- コンボスキル
		ContinualBreakCombo.combospan = 200							-- コンボ待ち時間
		ContinualBreakCombo.precombo = SKILL_ATK4			-- SKILL_ATK4にティンダーブレーカーが入っている想定
		ContinualBreakCombo.range = {1, 1, 1, 1, 1}
		
		-- EQC
		EternalQuickCombo = AttackSkill.new("EternalQuickCombo",8038)
		EternalQuickCombo.sp = {24, 28, 32, 36, 40}
		EternalQuickCombo.charge = {300000, 300000, 300000, 300000, 300000}
		EternalQuickCombo.skilltype = "COM"							-- コンボスキル
		EternalQuickCombo.combospan = 500							-- コンボ待ち時間
		EternalQuickCombo.precombo = SKILL_COM3			-- SKILL_COM3にCBCが入っている想定
		EternalQuickCombo.range = {1, 1, 1, 1, 1}
		
		SetSkillSlot(SKILL_SWT1, StyleChange)
		SetSkillSlot(SKILL_ATK3, SonicClaw)
		SetSkillSlot(SKILL_ATK4, TinderBreaker)
		SetSkillSlot(SKILL_COM1, SilverveinRush)
		SetSkillSlot(SKILL_COM2, MidnightFrenzy)
		SetSkillSlot(SKILL_COM3, ContinualBreakCombo)
		SetSkillSlot(SKILL_COM4, EternalQuickCombo)
		
	elseif CheckMyType(MyType) == SERA then
		-- サモンレギオン
		SummonLegion = AttackSkill.new("SummonLegion",8018)
		SummonLegion.sp = {60, 80, 100, 120, 140}
		SummonLegion.duration = {20000, 30000, 40000, 50000, 60000}
		SummonLegion.charge = {2000, 2000, 2000, 2000, 2000}
		SummonLegion.casting = {0,0,0,0,0}
		SummonLegion.range = {9, 9, 9, 9, 9}
		--SummonLegion.eachtarget = true
		
		-- ニードルオブパラライズ
		NeedleOfParalyze = AttackSkill.new("NeedleOfParalyze",8019)
		NeedleOfParalyze.sp = {48, 60, 72, 84, 96}
		NeedleOfParalyze.charge = {0, 4000, 8000, 12000, 16000}
		NeedleOfParalyze.casting = {0,0,0,0,0}
		NeedleOfParalyze.range = {5, 5, 5, 5, 5}
		
		-- ポイズンミスト
		PoisonMist = AttackSkill.new("PoisonMist",8020)
		PoisonMist.skillfunc = "GRD"
		PoisonMist.sp = {65, 75, 85, 95, 105}
		PoisonMist.duration = {12000, 14000, 16000, 18000, 20000}
		PoisonMist.charge = {2000, 2000, 2000, 2000, 2000}
		PoisonMist.casting = {0,0,0,0,0}
		PoisonMist.area = {7, 7, 7, 7, 7}
		
		-- ペインキラー
		PainKiller = BufferSkill.new("PainKiller",8021)
		PainKiller.sp = {48, 52, 56, 60, 64}
		PainKiller.duration = {30000, 27500, 25000, 22500, 20000}
		PainKiller.charge = {0, 30000, 30000, 60000, 60000}
		PainKiller.casting = {0,0,0,0,0}
		PainKiller.range = {9, 9, 9, 9, 9}
		PainKiller.target = MyOwner
		PainKiller.usestate[IDLE_ST] = true		-- 待機状態も使用するように
		PainKiller.usestate[FOLLOW_ST] = true		-- 追従状態も使用するように
		PainKiller.usestate[FOLLOW_CMD_ST] = true		-- 休息状態も使用するように
		PainKiller.usestate[MOVE_CMD_ST] = true		-- 手動移動中も使用するように
		PainKiller.usestate[SKILL_OBJECT_CMD_ST] = true		-- 手動状態も使用するように
		PainKiller.eachtarget = true
		
		SetSkillSlot(SKILL_BUF6, SummonLegion)
		SetSkillSlot(SKILL_BUF7, PainKiller)
		SetSkillSlot(SKILL_ATK3, NeedleOfParalyze)
		SetSkillSlot(SKILL_SHOOT, NeedleOfParalyze)
		SetSkillSlot(SKILL_ATK4, PoisonMist)
		
	end
	
end		-- SkillDefineここまで
--スキル関連関数変更
-- スキル詳細設定用 とりあえず空関数で定義
function SkillSetting()
	return
end
------------------------------------------------------------------------

--スキル全体としてのクラス

------------------------------------------------------------------------
Skill = {}
Skill.new = function (name,sid)
	local obj = {}
	obj.name = name											-- このスキルの名前
	obj.id = sid											-- このスキルのID
	obj.slotid = 0											-- このスキルがセットされたスロットID
	obj.skillfunc = "OBJ"									-- 対象指定(OBJ)：地面指定(GRD)
	obj.sp = {0,0,0,0,0}									-- このスキルの消費SP配列
	obj.AutoSkillSPLimit = Nilpo(AutoSkillSPLimit)			-- このスキルの使用許可SP％下限
	obj.AutoSkillSPLimit2 = Nilpo(AutoSkillSPLimit2)		-- このスキルの使用許可SP％上限
	obj.AutoSkillSPPer = AutoSkillSPPer						-- このスキルの使用許可SP下限を％判定
	obj.AutoSkillSPPer2 = AutoSkillSPPer2					-- このスキルの使用許可SP上限を％判定
	obj.delay = {1000,1000,1000,1000,1000}					-- このスキルのディレイ配列(ms)
	obj.duration = {0,0,0,0,0}								-- 効果時間の定義(ms)
	obj.charge = {1000,1000,1000,1000,1000}					-- 再使用時間の定義(ms)
	obj.casting = {0,0,0,0,0}								-- 詠唱時間の定義(ms)
	obj.hitcount = {0,0,0,0,0}								-- 設置系のHIT数の定義(回)
	obj.cooltime = 0										-- クールタイム管理(ms)
	obj.range = {30,30,30,30,30}							-- スキル射程
	obj.area = {1,1,1,1,1}									-- スキル範囲
	obj.limit = {}											-- 持続時間管理(ms)
	obj.usedlevel = 0										-- 使用済のレベル管理
	obj.usedtarget = 0										-- 使用相手のID管理
	obj.usedtime = 0										-- 使用時刻
	obj.usestate = {}										-- 使用する状態を指定
	obj.target = 0											-- 固有ターゲット指定
	obj.reserve = 0											-- 予約ターゲットID
	obj.manualuse = false									-- 手動発動時のフラグ（使用時はレベル値）
	obj.forceuse = false									-- 使用確率等を無視して100％発動する
	obj.limitbreak = false									-- 強制的に効果時間を無視する
	obj.premiseskill = nil									-- そのスキル発動の前提となるスキル名
	obj.premiseswitch = false								-- そのスキル発動の前提となるスキルの使用状態
	
	--SPチェック関数
	obj.spcheck = function(self)
		-- SP量の条件チェック：SPが下限以下もしくは上限超え
		local mysp_low = Actors[MyID].sp
		local mysp_high = Actors[MyID].sp
		if self.AutoSkillSPPer == 1 then
			mysp_low = Actors[MyID].spp
		end
		if self.AutoSkillSPPer2 == 1 then
			mysp_high = Actors[MyID].spp
		end
		if self.AutoSkillSPLimit >= mysp_low or self.AutoSkillSPLimit2 < mysp_high then
			return false
		end
		return true
	end
	obj.usestateCheck = function(self)
		-- 使用可能な状態かチェック
		if TableSize(self.usestate) > 0 then
			if not self.usestate[MyState] then	-- 使用可能状態が設定済みで、許可されていない状態の場合
				TraceAI("no state "..self.name)
				return false
			end
		end
		return true
	end
	-- 効果時間とクールタイムのチェック
	obj.usespanCheck = function(self,target)
		if self.cooltime >= GetTick() then
			return false
		end
		if self.limitbreak then		-- 強制的に効果時間を無視する場合
			return true
		end
		if self:limitCheck(target) >= GetTick() then
			-- 交換時間内でもターゲット変化で再使用判定があれば
			if self.eachtarget and self.usedtarget ~= target then
				return true
			end
			return false
		end
		return true
	end
	-- 効果時間管理の取得
	obj.limitCheck = function(self,target)
		if self.eachtarget then
			return Nilpo(self.limit[target])
		else
			return Nilpo(self.limit[1])
		end
	end
	-- 効果時間管理の設定
	obj.limitSet = function(self,target,val)
		if self.eachtarget then
			self.limit[target] = val
		else
			self.limit[1] = val
		end
	end
	-- スキル使用関数
	obj.go = function(self, myid, level, target, posx, posy)
		local mysp = GetV(V_SP,myid)
		local d = GetSqDistance(myid,target)
		if SkillDelay < GetTick() and self.usespanCheck(self,target) and self:usestateCheck() then		-- ディレイ&クールタイム超過&SP制限OK
			if mysp > Nilpo(self.sp[level]) and level > 0 and target > 0 and d <= self.range[level] then					-- SPが足りて、Lvが設定されていて、射程内の場合
				--前提スキルのチェック
				if not self:premise(level) then return 1 end												-- 前提スキルを使用していない場合、使用して抜ける
				beforeSP = mysp																			-- 発動前のSP記録
				if Nilpo(posx) > 0 and Nilpo(posy) > 0 then												-- 地面指定の場合
					SkillGround(myid,level,self.id,posx, posy)													-- スキル使用
				else																					-- 対象指定の場合
					SkillObject(myid,level,self.id,target)													-- スキル使用
				end
				local casting =  Nilpo(self.casting[level])
				local duration_rate = Nilpo(self.AutoDurationCut) / 100								-- 再使用時限割合
				self:limitSet(target, GetTick() + Nilpo(self.duration[level])*duration_rate + casting)				-- 時限記録
				self.cooltime = GetTick() + Nilpo(self.charge[level]) + casting							-- クールタイム記録
				self.usedlevel = level																	-- 使用レベル記録
				self.usedtarget = target																-- 使用相手記録
				self.usedtime = GetTick()																-- 使用時刻
				self.manualuse = false																	-- 手動発動時のフラグ消去
				self.forceuse = false																	-- 強制発動のフラグ消去
				self.limitbreak = false																	-- 強制発動のフラグ消去
				SkillDelay = Nilpo(self.delay[level]) + casting + GetTick()								-- スキルディレイ設定
				OnCasting = casting + GetTick()															-- 詠唱時間設定
				if self.skilltype == "SWT" then
					self.switch = T2F(self.switch)															-- スイッチ
				end
				SkillTimeKeep(skill,t)																	-- ディレイ管理外部ファイルに保存
				TraceAI("----> "..self.name.." used! -- Lv:"..level.."  Target:"..target.." SkillDelay:"..self.delay[level].." CoolTime:"..(self.cooltime-GetTick()).."  totalDelay:"..SkillDelay.." --at : "..GetTick())
				return 1
			end
		end
		--TraceAI("--Skill Faild::"..self.name.." used! -- Lv:"..level.." SkillDelay:"..Nilpo(self.delay[level]).." CoolTime:"..(self.cooltime-GetTick()).."  totalDelay:"..SkillDelay.." --at : "..GetTick())
		return 0
	end
	-- クールタイムをキャンセルする関数
	obj.cancel = function (self)
		self.cooltime = GetTick() + 3000
		self:limitSet(self.target, GetTick() +3000)
		SkillDelay = GetTick() +1000
		if self.skilltype == "COM" and self.precombo then		--コンボ前スキルが設定されている
			SkillDelay = GetTick()
			Skills[self.precombo].comboused = GetTick()
		end
		TraceAI("xxxxx "..self.name.." calceled! --  LimitTime:"..(self:limitCheck(self.target)-GetTick()).." CoolTime:"..(self.cooltime-GetTick()).."  totalDelay:"..SkillDelay.." --at : "..GetTick())
	end
	-- 前提スキルをチェックする関数
	obj.premise = function (self, level)
		if self.premiseskill then		-- 前提スキルのセットがある
			local psid = self.premiseskill.slotid		-- 前提スキルのスロットID取得
			if psid > 0 then									-- 前提スキルがスロットにある
				if Skills[psid].skilltype == "SWT" then			-- 前提スキルがスイッチ系
					--スイッチ状態をチェック
					if self.premiseswitch == Skills[psid].switch then		-- このスキルが必要とする状態と現在の前提スキルの状態の比較
						-- 一致していれば問題なし
						return true
					else
						--状態が違う場合は
						local slotid = self.slotid		-- このスキルのスロットID取得
						TraceAI("---++++++--- Reserve Skill:"..self.name.." slot:"..self.slotid)
						Skills[psid].limitbreak = true				-- 前提スキルの使用を許可して
						if UseSlotSkill(MyID,psid,MyID,Skills[psid].BufferLevel) == 1 then		--前提スキルを使用する
							if SetReserveSkill(slotid, level) == 1 then		-- このスキルを予約テーブルにセット
								self.cooltime = GetTick() + 500		-- 念のためクールタイム0.5秒追加
								self.usedlevel = level				-- 使用Lv指定
								self.forceuse = true				-- 強制使用フラグを立てておく
								-- 今回このスキルは使用しない
								TraceAI("reserved.."..slotid)
							end
						end
						return false
					end
				elseif Skills[srsid].skilltype == "BUF" then			-- 前提スキルが強化系
					--効果時間内かをチェックする
					
				end
			end
		end
		-- セットが無ければ問題なし
		return true
	end
	
	-- スキル定義完了
	return obj
end
-- スキルクラスを継承して攻撃スキルクラスを定義
AttackSkill = {}
AttackSkill.new = function (name,sid)
	local obj = Skill.new(name,sid)
	obj.skilltype = "ATK"							-- このスキルのタイプ
	obj.precombo = nil								-- コンボの直前スキルスロットID
	obj.FirstAttack = FirstAttack					-- 初撃スキルの設定値
	obj.AutoAttackSkill = AutoAttackSkill			-- オートスキルの設定値
	obj.CrossFire = CrossFire						-- クロスファイアの設定値
	obj.AutoAdjust = AutoAdjust						-- 自動レベル調整の設定値
	obj.AS_threshold = AS_threshold					-- AS自動レベル調整の時間指定値
	obj.AS_SkillLevel = Nilpo(AS_SkillLevel)		-- 使用レベルの設定値
	obj.FA_SkillLevel = Nilpo(FA_SkillLevel)		-- 初撃使用レベルの設定値
	obj.ShootLevel = Nilpo(ShootLevel)				-- 援護射撃使用レベルの設定値
	obj.AspBase = Nilpo(AspBase)					-- AS基本確率
	obj.ASP_MagniT = ASP_MagniT						-- AS時間経過倍率の設定値
	obj.AspCoefficient = AspCoefficient				-- AS確率係数
	obj.AspExponential = AspExponential				-- AS確率指数
	obj.AttackLimit = AttackLimit					-- 敵の数条件
	obj.AutoDurationCut = Nilpo(AutoDurationCut)		-- 自動スキルのかけ直しの効果時間のN％から行う
	obj.usestate = {}		-- 常時発動
	obj.combospan = 0								-- コンボの待ち時間
	obj.comboused = 0								-- コンボの使用管理
	
	--ASの確率計算
	obj.calcprob = function (self,mid)
		local p = 0
		p = self.AspBase + Nilpo(Mob[mid][M_AS]) + Nilpo(eInfo.addasp) + self.AspCoefficient*(ActorInfo(MyID,"spp")/100)^self.AspExponential
		p = p * VariableASP(mid,self.ASP_MagniT,Nilpo(eInfo.battletime)) + AdditionalProb
		return p
	end
	-- 攻撃スキルの使用判定をする関数
	obj.use = function (self,myid,target,lv)
		if IsMonster(target) == 1 and SkillDelay < GetTick() and self.cooltime < GetTick() and self:spcheck() then
			self.target = target					-- 今回のターゲット
			local useFlag = false					-- 使用判定フラグ
			local level = 0							-- 設定レベル
			local id = GetV(V_HOMUNTYPE,target)		--ターゲットのID
			if Nilpo(eInfo.skillcountlimit) == 0 then					--使用回数制限が未設定なら設定
				eInfo.skillcountlimit = ActorInfo(target,"m","skillc")
			end
			if Nilpo(eInfo.skillcount) >= eInfo.skillcountlimit and eInfo.skillcountlimit ~= 0 then
				TraceAI("AutoSkill count out ...")
				return		-- リミットが0ではなく、回数を超えていたら抜ける
			end
			if self.AttackLimit > OurEnemysCount then
				return 0
			elseif GetV(V_MOTION,myid) == MOTION_DAMAGE then		-- 自身がダメージモーションの時は使用しない
				TraceAI(" motion DAMEGE")
				return 0
			end
			--追跡中
			if MyState == CHASE_ST then
				if self.FirstAttack and self.FA_OnChase and Nilpo(eInfo.skillcount) == 0 then		-- 初撃あり、追跡中初撃あり、回数0
					useFlag = true
				else
					return 0			--それ以外は不使用で抜ける
				end
			end
			
			if self.FirstAttack and  Nilpo(eInfo.skillcount) == 0 then			-- 初撃フラグがある場合かつ回数0
				useFlag = true
			elseif eInfo.onlyskill or self.manualuse then							-- フルスキル・手動発動のとき
				useFlag = true
			elseif self.reserve == target then				-- 予約IDがターゲットと同じ
				useFlag = true
			elseif self.forceuse then				-- 強制使用
				TraceAI("--+ Force Use!!")
				useFlag = true
			elseif self.AutoAttackSkill then				--オート使用
				if self.CrossFire then
					if GetV(V_MOTION,MyOwner) == MOTION_SKILL then
						TraceAI("--+ CrossFire!!")
						useFlag = true
					end
				end
				local dice = math.random(1000)/10
				--local prob = self.AspBase + Nilpo(Mob[id][M_AS]) + Nilpo(eInfo.addasp) + self.AspCoefficient*(GetPerSP(myid)/100)^self.AspExponential
				eInfo.prob = self.calcprob(self,id)
				--TraceAI("EnemyID : "..target.." type: "..id.."   dice : "..dice.."    prob : "..eInfo.prob.." (addasp : "..Nilpo(eInfo.addasp) + Nilpo(Mob[id][M_AS])..")")
				if dice < eInfo.prob then
					useFlag = true
				end
			end
			-- コンボスキルの場合
			if self.precombo then
				--対応するスキルの直前の使用時間
				local preTick = Nilpo(Skills[self.precombo].comboused)
				if preTick > 0 then
					--他コンボスキルの待機時間をチェック
					for i,s in ipairs(ASTable[AST_Number]) do
						if Skills[s].precombo then	--コンボ設定スキル
							-- コンボ前スキルの使用時間を比較
							if Skills[Skills[s].precombo].usedtime > Skills[self.precombo].usedtime then
								TraceAI("other combo skill -------------**-------------")
								return 0			-- 他のコンボ中なら遠慮する
							end
						end
					end
					if preTick > GetTick() or preTick + 2000 < GetTick() then		--コンボ待機時間以下または待機時間後2秒以上経過でキャンセル
						useFlag = false
						TraceAI(self.name.." is after of "..self.precombo.."  the preusetime:"..preTick.." now:"..GetTick())
						--TraceAI("under combo! Time over---")
					else
						--TraceAI("use combo!------------------!")
						--useFlag = true	--スルー
						if useFlag then
							--使用フラグ立ってた
							TraceAI("use combo!---------"..self.name.."-------!")
							Skills[self.precombo].comboused = 0
						end
					end
				else
					--TraceAI("no combo!")
					useFlag = false	--スルー
				end
			end
			-- 使用フラグが立っていればレベルを決めて使用
			if useFlag then
				
				level = ActorInfo(target,"m","skill")		-- Mob別設定を取得
				if lv then			-- Lv指定があればそのレベルで発動
					level = lv
				elseif self.manualuse then
					level = self.manualuse			-- manualuseのレベルで
				else
					if Nilpo(eInfo.skillcount) == 0 and self.FirstAttack and level ~= 0 then	--初撃の場合のレベル設定
						level = self.FA_SkillLevel
					else
						if level == 6 then
							if self.AutoAdjust and not self.PrevAA then								-- 使用レベルの自動調整
								level = AdjustSkillLevel(id,self.AS_SkillLevel,self.AS_threshold)
							else
								level = self.AS_SkillLevel
							end
						end
						level = level + Nilpo(eInfo.addasl)
						if level >= 5 then
							level = 5
						end
					end
					if level == 0 then		--レベルが0の場合は設定値で使用
						if MyState == SHOOTING_ST then
							level = self.ShootLevel
						elseif eInfo.onlyskill then
							level = self.AS_SkillLevel
						end
					end
				end
				
				-- 地面指定かどうか
				local posx, posy = 0, 0
				local effected = 0
				if self.skillfunc == "GRD" and level > 0 then
					posx, posy = Actors[target].posx, Actors[target].posy
					--展開座標を自動調整する
					if AutoAdjustPoint and OurEnemysCount >= 2 then		-- 敵が複数の時のみ
						posx, posy, effected = AdjustGroundPoint(self.area[level], self.range[level], target, OurEnemys, OurEnemysCount)
					end
				end
				
				-- 射程が足りてなければ移動
				if MoveInRange(self.range[level],target) == 1 then
					eInfo.onmove = true
					self.reserve = target
					TraceAI("Move to in Range")
					return 0
				else
					eInfo.onmove = false
					self.reserve = 0
				end
				if self:go(myid,level,target,posx,posy) == 1 then					--スキル使用
					eInfo.skillcount = Nilpo(eInfo.skillcount) + 1			-- カウントアップ
					--自身のコンボ時間制限を設定
					self.comboused = GetTick() + self.combospan		-- 待ち時間設定
					if self.precombo then		--コンボ前スキルが設定されている
						Skills[self.precombo].comboused = 0
					end
					-- 設置系のHIT数
					if self.skillfunc == "GRD" then		--設置系
						if self.hitcount[level] > 0 and effected > 0 then		--HIT数設定があるかつ影響範囲が0より上
							-- 敵の数の多さに応じて、クールタイムと効果時間を再設定減らす
							local des =  Nilpo(2000 * math.ceil(self.hitcount[level]/effected))
							local casting =  Nilpo(self.casting[level])
							self.cooltime = GetTick() + des + casting
							self:limitSet(GetTick() + des + casting, target)
							TraceAI(" *-*-* fitting cooltime : "..self.cooltime.." and limit : "..self:limitCheck(target))
						end
					end
					return 1
				end
			end
		end
		return 0	-- スキルの使用がなければ0を返す
	end				-- スキル使用関数ここまで
	return obj		-- 攻撃スキルクラス定義完了
end

-- スキルクラスを継承して強化スキルクラスを定義
BufferSkill = {}
BufferSkill.new = function (name,sid)
	local obj = Skill.new(name,sid)
	obj.skilltype = "BUF"							-- このスキルのタイプ
	obj.BufferLevel = Nilpo(BufferLevel)			-- 使用レベルの設定値
	obj.AutoBufferSkill = AutoBufferSkill			-- 自動強化スキルを使うかの設定値
	obj.BufferLimit = Nilpo(BufferLimit)		-- 自動強化スキルを敵何匹から使うかの設定値
	obj.AutoBufferHP = Nilpo(AutoBufferHP)		-- 自動回復スキルを使う主人のHP％の設定値
	obj.AutoBufferMyHP = Nilpo(AutoBufferMyHP)		-- 自動回復スキルを使う自分のHP％の設定値
	obj.exclusive = false						-- 排他制御
	obj.usedlevel = Nilpo(BufferLevel)			-- 使用済のレベル管理
	obj.usestate = {}							-- 使用する状態を指定
	obj.usestate[ATTACK_ST] = true				-- 戦闘中使用
	obj.usestate[SHOOTING_ST] = true			-- 援護射撃中使用
	
	-- 強化スキルの使用判定をする関数
	obj.use = function (self,myid,target,lv)
		if SkillDelay < GetTick() and self.cooltime < GetTick() and self:spcheck() then
			-- 使用設定がある敵が居るか
			local splv = 0
			
			if self.AutoBufferSkill then
				-- 条件
				-- HP％が指定より多い場合は使わない
				local ohpp = ActorInfo(MyOwner,"hpp")
				local myhpp = ActorInfo(MyID,"hpp")
				if self.AutoBufferHP < ohpp and self.AutoBufferMyHP < myhpp then
					return 0
				end
				-- 敵の数が設定値未満だったら抜ける
				if self.BufferLimit > OurEnemysCount then
					return 0
				elseif GetV(V_MOTION,myid) == MOTION_DAMAGE then		-- 自身がダメージモーションの時は使用しない
					TraceAI(" motion DAMEGE")
					return 0
				end
				-- 他スキルのうち排他制御ありのスキルのクールタイム内だったら無効
				for i,s in pairs(Skills) do
					if s.exclusive and s.skilltype == "BUF" and Nilpo(s.cooltime) > GetTick() then
						--TraceAI(s.exclusive.." and "..self.name)
						--if string.match(s.exclusive, self.name) then
						if s.exclusive == self.name then
							TraceAI(" =!= Now cooltime in "..s.name.." for "..self.name)
							return 0
						elseif s.exclusive == "all" then
							TraceAI(" =!= Now cooltime in "..s.name)
							return 0
						end
					end
				end
				--レベル指定があればそのレベルで
				local uselv = self.BufferLevel
				if lv then
					uselv = lv
				elseif splv > 0 then
					uselv = splv
				end
				-- ターゲットは基本自分である
				local t = myid
				if self.target > 0 then				-- スキル自体にターゲット指定があれば
					t = self.target
					--TraceAI("target is "..t)
				end				
				if target and IsMonster(target) == 0 then		-- Mob以外のtargetが指定されていれば
					t = target
					--TraceAI("target is "..t)
				end

				
				-- 地面指定かどうか
				local posx, posy = 0, 0
				local effected = 0
				if self.skillfunc == "GRD" and level > 0 then
					posx, posy = Actors[t].posx, Actors[t].posy
					--展開座標を自動調整する
					if AutoAdjustPoint and OurEnemysCount >= 2 then		-- 敵が複数の時のみ
						posx, posy, effected = AdjustGroundPoint(self.area[level], self.range[level], target, OurEnemys, OurEnemysCount)
					end
				end
				
				-- 射程が足りてなければ移動
				if MoveInRange(self.range[uselv],t) == 1 then
					eInfo.onmove = true
					self.reserve = target
					return 0
				else
					eInfo.onmove = false
					self.reserve = 0
				end
				if self:go(myid,uselv,t,posx,posy) == 1 then					--スキル使用
					
					return 1
				end
			end
		end
		return 0	-- スキルの使用がなければ0を返す
	end
	return obj		-- 強化スキルクラス定義完了
end

-- スキルクラスを継承して回復スキルクラスを定義
RecoverSkill = {}
RecoverSkill.new = function (name,sid)
	local obj = Skill.new(name,sid)
	obj.skilltype = "REC"							-- このスキルのタイプ
	obj.RecoverLevel = Nilpo(RecoverLevel)			-- 使用レベルの設定値
	obj.AutoRecoverSkill = AutoRecoverSkill			-- 自動回復スキルを使うかの設定値
	obj.AutoRecoverHP = Nilpo(AutoRecoverHP)		-- 自動回復スキルを使う主人のHP％の設定値
	obj.AutoRecoverMyHP = Nilpo(AutoRecoverMyHP)		-- 自動回復スキルを使う自分のHP％の設定値
	obj.usedlevel = Nilpo(RecoverLevel)			-- 使用済のレベル管理
	obj.useitemcheck = false					-- 消費アイテムチェックをするスキル
	obj.noitem = 0								-- 触媒なしと判断されたフラグ
	obj.noenemy = false							-- Mobが居ないときに使用する（CV用）
	obj.holdedtarget = false					-- 固定ターゲット（主人のみしか対象にできない、自分しか対象にできないなど）
	obj.hp		= 0								-- このスキルを使った時の対象のHP
	-- 回復スキルの使用判定をする関数
	obj.use = function (self,myid,target,lv)
		if SkillDelay < GetTick() and self.cooltime < GetTick() and self:spcheck() then
			if self.AutoRecoverSkill then
				
				--レベル指定があればそのレベルで
				local uselv = self.RecoverLevel
				if lv then
					uselv = lv
				end
				
				-- 画面内に植物以外の敵が居るときは使用しない
				if self.noenemy then
					for i,v in pairs(Enemys) do		-- 画面内敵チェック
						if IsPlant(v) == 0 and IsRegion(v) == 0 then		-- 植物/レギオン以外のMobが居れば
							return 0				-- 使用しない
						end
					end
				elseif self.name == "ChaoticVenediction" then				-- CVの場合
					for i,v in pairs(Enemys) do		-- 画面内敵チェック
						if IsOther(GetV(V_TARGET,v)) == 1 and IsRegion(v) == 0 then		-- 他人と交戦中のMobがいたら(レギオンは除外)
							return 0				-- 使用しない
						end
					end
				end
				
				-- HP管理
				local ohp = GetV(V_HP,target)
				--消費アイテムチェック
				if self.useitemcheck then
					if ohp == self.hp and self.usedtime+Nilpo(self.delay[self.usedlevel])+ 1000 < GetTick() then		-- ディレイ+1秒程度の再使用時に対象のHPに変化がない
						self.noitem = self.noitem +1								-- アイテムなしにカウントアップ
						if self.noitem > 3 then										-- 4周アウトしたら
							self.cooltime = GetTick() + 60*1000						-- 60秒クールタイム
							return 0
						end
					else
						self.noitem = 0							-- 回復しているようならカウント0に
					end
				end
				if self.holdedtarget then				-- 固定ターゲットがある場合
					target = self.holdedtarget
				elseif Nilpo(target) == 0 then
					target = GetV(V_OWNER,myid)			-- ターゲット指定がなかったらとりあえず主人
				end
				-- 射程が足りてなければ移動
				if MoveInRange(self.range[uselv],target) == 1 then
					eInfo.onmove = true
					self.reserve = target
					return 0
				else
					eInfo.onmove = false
					self.reserve = 0
				end
				if self:go(myid,uselv,target) == 1 then					--スキル使用
					self.hp = ohp	-- 対象の現在HPを記録
					return 1
				end
			end
		end
		return 0	-- スキルの使用がなければ0を返す
	end
	return obj		-- 回復スキルクラス定義完了
end

-- 強化スキルクラスを継承して加速スキルクラスを定義
AccelSkill = {}
AccelSkill.new = function (name,sid)
	local obj = BufferSkill.new(name,sid)
	obj.skilltype = "ACC"
	if CheckMyType(MyType) == LIF then				-- リーフのみ（ホムSは任意指定）
		obj.AutoBufferSkill = EmergencyAvoid				-- 加速スキルの使用可否
	else
		obj.AutoBufferSkill = false
	end
	obj.BufferLimit = 0									-- 敵の数処置関係なし
	obj.BufferLevel = EA_Level							-- 加速レベルで
	return obj
end
-- 強化スキルクラスを継承してスイッチスキルクラスを定義
SwitchSkill = {}
SwitchSkill.new = function (name,sid)
	local obj = BufferSkill.new(name,sid)
	obj.skilltype = "SWT"
	obj.switch = false							-- このスキルのスイッチ管理
	
	-- スイッチスキルの使用判定をする関数
	obj.use = function (self,myid,target,lv)
		if SkillDelay < GetTick() and self.cooltime < GetTick() and self:spcheck() then
			if self.AutoBufferSkill then
				local splv = 0
				local useFlag = false					-- 使用判定フラグ
				if GetV(V_MOTION,myid) == MOTION_DAMAGE then		-- 自身がダメージモーションの時は使用しない
					TraceAI(" motion DAMEGE")
					return 0
				end
				
				if self.limitbreak then
					TraceAI(" Switch !!!")
					useFlag = true
				end
				
				if useFlag then
					--レベル指定があればそのレベルで
					local uselv = self.BufferLevel
					if lv then
						uselv = lv
					elseif splv > 0 then
						uselv = splv
					end
					-- ターゲットは基本自分である
					local t = myid
					if target and IsMonster(target) == 0 then		-- Mob以外のtargetが指定されていれば
						t = target
						--TraceAI("target is "..t)
					elseif self.target > 0 then				-- スキル自体にターゲット指定があれば
						t = self.target
						--TraceAI("target is "..t)
					end
					if self:go(myid,uselv,t) == 1 then					--スキル使用
						TraceAI(" Switch used !!!")
						
						return 1
					end
				end
			end
		end
		return 0
	end
	-- キャンセル関数も上書き
	obj.cancel = function (self)
		SkillDelay = GetTick() +200
		self.switch = T2F(self.switch)		-- スイッチをもどす
	end
	return obj
end
function ResetCombo()
	-- コンボスキルのリセット
	if CheckMyType(MyType) == ELEANOR then
		for i,s in pairs(Skills) do
			s.comboused = 0
		end
	end
end
-- サモンレギオンのスタック対策
function RegionMate()
	--タイプがセラ型のみ
	if CheckMyType(MyType) == SERA then
		--レギオンの持続時間が指定時間以下の場合
		local srsid = GetSkillSlotID("SummonLegion")
		local ct = Nilpo(Skills[srsid]:limitCheck(MyID))
		local lt = Nilpo(Skills[srsid].duration[Skills[srsid].usedlevel]) * (RegionResetRate/100)
		if ct > 0 then
			TraceAI("-******- Limit:"..ct.."  Duration:"..lt)
			if ct - lt > GetTick() then		-- 許容効果時間内なら
				-- 周囲をスキャンしてレギオンをターゲット
				for id,v in pairs(Enemys) do
					if IsRegion(id) == 1 then
						--1回だけ攻撃命令
						if MyEnemy == 0 then
							Attack(MyID,id)	-- 攻撃
						else
							Attack(MyID,MyEnemy)	-- 攻撃
						end
						return
					end
				end
			else
				-- 時間切れしていたら
				Skills[srsid].limitbreak = true			-- 次回強制発動
				--PrintMessage(201,MyID, Skills[srsid].id, Skills[srsid].usedlevel,0,1)	--キャンセルメッセージ
				TraceAI("-***!!!***- New Region !")
			end
		end
	end
end
------///////////////////////////////////////////////////////////////////////////////////////////////////////---------
-----------------------------------------------------------------------------------------------
-- オート回復スキル
-----------------------------------------------------------------------------------------------
function AutoRecover(myid)
	--1個も定義がなかったら抜ける
	if not Skills[SKILL_RES1] then
		return
	end
	local owner = GetV(V_OWNER,myid)
	-- スロットの回復スキル操作
	for slot = SKILL_RES1 , SKILL_RES5, 1 do
		if Skills[slot] then
			if Actors[owner].hpp < Skills[slot].AutoRecoverHP then
				Skills[slot]:use(myid,owner)			-- 主人へ回復スキル発動
			elseif Actors[myid].hpp < Skills[slot].AutoRecoverMyHP then
				local level = nil
				if Skills[slot].name == "ChaoticVenediction" then			--CVの場合レベル4固定
					level = 4
				end
				Skills[slot]:use(myid,myid)			-- 自分へ回復スキル発動
			end
		end
	end
end
-----------------------------------------------------------------------------------------------
-- スキルの使用時間を保守する関数
-----------------------------------------------------------------------------------------------
function SkillTimeKeep(skill,t)
	-- スキル使用時間を保存
	-- 暗転を考えて、ディレイに若干の水増しをする
	local addedDelay = 700
	local filename = SaveDir.."Time.lua";
	local fp = io.open(filename,"w")
	if fp then
		local params = ""
		local switchstate = ""
		for i,v in pairs(Skills) do
			--TraceAI("skill "..v.name)
			if v.cooltime > GetTick() then
				params = params..v.name..".cooltime = "..(v.cooltime + addedDelay).."\n"
			end
			for j,l in pairs(v.limit) do
				if l > GetTick() then
					params = params..v.name..".limit["..j.."] = "..(l + addedDelay).."\n"
				end
			end
			if v.skilltype == "SWT" then
				if v.switch then
					switchstate = switchstate..v.name..".switch = true\n"
				else
					switchstate = switchstate..v.name..".switch = false\n"
				end
			end
		end
		fp:write("function InheritSkillState()\n")
		fp:write(params)
		fp:write("end\n")
		-- スイッチ管理
		--fp:write("if CheckMyType(MyType) == "..CheckMyType(MyType).." then\n")
		fp:write(switchstate)
		--fp:write("end\n")
		fp:write("PreMyID = "..MyID.."\n")
		fp:write("PreDelay = "..(SkillDelay+addedDelay).."\n")
		fp:write("TimeStamp = "..os.time())
		fp:close()
	end
end
function LoadTimeKeep()
	local filereqire = SaveDir.."Time"
	local fileext = ".lua"
	local filename = filereqire..fileext
	if IncludeFiles(filereqire, fileext) then		-- Timeファイルインクルード
		if MyID == Nilpo(PreMyID) then		-- IDが同じ場合、テレポなどの可能性
			InheritSkillState()				-- スキル状態の継承
			SkillDelay = Nilpo(PreDelay)	-- ディレイ値の継承
			return -2
		else
			
		end
	end
	return -1
end
--ダミー関数
function InheritSkillState()
	return 0
end
-----------------------------------------------------------------------------------------------
-- 敵と座標が重なってる時に移動させる関数
-----------------------------------------------------------------------------------------------
function AvoidOverlap()
	local x,y = GetV(V_POSITION,MyID)
	if OverlapFlag < AwayCount and MoveDelay < GetTick() then
		OverlapFlag = OverlapFlag + 1
		local dx, dy = 0,0
		if AwayType == 0 then									-- 回避タイプ0：絶対座標
			dx, dy = AvoidDirection[OverlapFlag].x*AwayStep, AvoidDirection[OverlapFlag].y*AwayStep
		elseif AwayType == 1 then
			local ox,oy = GetV(V_POSITION,MyOwner)				-- 主人の座標
			local ex,ey = GetV(V_POSITION,MyEnemy)				-- 敵の座標
			dx,dy = VectorCheck(ox,oy,ex,ey)					-- 主人から見た敵の方向
			dx, dy = dx*AwayStep, dy*AwayStep					-- 係数かける
			if (dx ==0 and dy == 0) or CheckCell(LocalMap,x+dx,y+dy) == 1 then	-- どっちも0（主人，ホム，敵全て同座標のケース）または移動先に誰か居る
				dx, dy = CheckEmptyCell(ex,ey,AttackDistance)
				dx, dy = dx*AwayStep, dy*AwayStep					-- 係数かける
			end
		else 
			local ex,ey = GetV(V_POSITION,MyEnemy)				-- 敵の座標
			dx, dy = CheckEmptyCell(ex,ey,AttackDistance)
			dx, dy = dx*AwayStep, dy*AwayStep					-- 係数かける
		end
		Move(MyID,x+dx,y+dy)										-- 目標点へ移動
		MoveDelay = 140*AwayStep + GetTick()		-- 移動ディレイ計算
		--TraceAI ("Overlapped!!     count:"..OverlapFlag)
		return
	end
end
-----------------------------------------------------------------------------------------------
-- x,yの周辺dist以内で空いてるセルチェック
-----------------------------------------------------------------------------------------------
function CheckEmptyCell(x,y,dist)
	if not dist then dist = 1 end
	for i=-1*dist, dist, 1 do
		for j=-1*dist, dist, 1 do
			if CheckCell(LocalMap,x+i,y+j) == 0 and CheckCell(GlobalMap,x+i,y+j) > -1 then		--誰もいないセルをみつけたら
				return i,j
			end
		end
	end
	OverlapFlag = AwayCount
	return x,y
end
-----------------------------------------------------------------------------------------------
-- 指定の敵に対し詠唱妨害する関数
-----------------------------------------------------------------------------------------------
function PreventCasting(enemys)

	local preventTarget = 0
	local dis = 100
	local min_dis = 100
												-- リストがあれば
	--castingList = GetMotionActors(enemys,{MOTION_CASTING})		-- 詠唱中のMob
	--preventTarget = GetNearActorID(MyID, castingList)
	
	-- 詠唱中の最寄の相手
	for i,v in ipairs(enemys) do
		if ActorInfo(v,"motion") == MOTION_CASTING then
			dis = GetDistance2(MyID,v)
			if dis ~= -1 and dis < min_dis then
				min_dis = dis
				preventTarget = v
			end
		end
	end
	
	if preventTarget ~= 0 and preventTarget ~= MyEnemy then
		if GoSlotSkill(MyID,SKILL_SHOOT,preventTarget,1) == 1 then
			TraceAI(" /// Prevent Casting !! ")
			return
		elseif GetDistance2(MyID,preventTarget) < 3 then		-- スキルなしまたはディレイ中で距離が2以内なら
			Attack(MyID,preventTarget)							-- 通常攻撃で妨害
			ReturnFlag = true
		end
	end
end

-----------------------------------------------------------------------------------------------
-- 敵のチェックをする関数
-----------------------------------------------------------------------------------------------
function CheckEnemy(list,num)
	local enemys = list
	local actEscape = {}		-- 逃げる敵リスト
	local escIndex = 0			-- 逃げる敵インデックス
	local castOn = {}			-- 詠唱妨害リスト
	local castIndex = 0			-- 詠唱妨害インデックス
	local preTarget = 0			-- ターゲットチェンジ対象
	local robEnemys = {}		-- タゲ集め対象の敵リスト
	local robIndex = 0			-- タゲ集め対象の敵インデックス
	local targetMeCount = 0		-- 自分をターゲットしてる敵の数
	-- listは攻撃されているMobリストなので、まだ相手からはターゲットされてない敵も追加
	--if GetV(V_TARGET,MyEnemy) then
		if GetV(V_TARGET,MyEnemy) == 0 then
			enemys[num+1] = MyEnemy
		end
	--end
	for i,v in pairs(enemys) do
		local act = ActorInfo(v)
		if act ~= -1 then
			if act.type > 0 and v < 100000 then
				if act.m.act == ACT_ESCAPE then					-- 退避設定なら
					escIndex = escIndex + 1
					actEscape[escIndex] = v
				end
				if act.m.cast == CAST_ON then					-- 詠唱妨害ONなら
					castIndex = castIndex + 1
					castOn[castIndex] = v
				end
				if act.m.rank >= 1 then					-- 優先度1以上
					local rank = MathThreshold(act.m.rank,20) + AddPriority(v)
					if rank then				-- 優先度10以上で条件
						if preTarget == 0 then
							preTarget = v
						else
							local pRank = ActorInfo(preTarget,"m","rank")
							pRank = MathThreshold(pRank,20) + AddPriority(preTarget)
							if rank > pRank then
								preTarget = v
							end
						end
					end
				end
				if not act.attacked and GetDistance2(MyID,v) <= 2 and act.onbattletime < 2000 then			-- 未攻撃で距離2以内の敵
					if act.target ~= MyID and v ~= MyEnemy and ActorInfo(v,"m","act") >= 3 then					-- 現在攻撃中の敵ではなく、自分を攻撃していない
						robIndex = robIndex + 1
						robEnemys[robIndex] = v
					end
				end
				if act.target == MyID then				-- 自分を攻撃している敵の数カウント
					targetMeCount = targetMeCount +1
				end
				-- チェックここまで
			end
		end
	end
	
	if actEscape[1] then					-- 退避Mobが居たら
		EscapeFromDanger(actEscape)			-- 特定退避行動
		return
	end
	
	if PreventEnemyCasting and castOn[1] then		-- 詠唱妨害ONなら
		PreventCasting(castOn)					-- 詠唱妨害する
	end
	
	if preTarget ~= 0 then							-- ターゲット変更
		local preRank = MathThreshold(ActorInfo(preTarget,"m","rank"),20) + AddPriority(preTarget)
		if preRank <= 15 then				-- 15以下なら
			local o_target = GetV(V_TARGET,MyOwner)
			if o_target > 0 and IsMonster(o_target) == 1 and not FollowOwnerTargetting then
				local o_rank = MathThreshold(Mob[GetV(V_HOMUNTYPE,o_target)][M_RANK],20)
				if o_rank > 10 then	-- 主人のターゲットの敵優先度が11以上
					ChangeTarget(MyOwner)								-- 主人のタゲに変更
				end
			end
		else
			local nowRank = 20
			local nID = GetV(V_HOMUNTYPE,MyEnemy)
			if nID > 0 then 
				nowRank = MathThreshold(Mob[nID][M_RANK],20) + AddPriority(MyEnemy)
			end
			if preRank > nowRank then
				ChangeTarget(preTarget)				-- 最優先の敵へターゲット変更
			end
		end
	else							-- 最優先ターゲットが無い状況では主人のターゲットを見る
		if robEnemys[1] and RobTarget > 0 and targetMeCount <= RobTarget then		-- タゲ集め対象がいて、抱えている敵が設定値以下
			local robbimgEnemy = GetNearActorID(MyID,robEnemys)	-- 一番近い相手
			--TraceAI(" --------change owners target  : "..ownersEnemy)
			if robbimgEnemy ~= 0 then
				-- ターゲット奪う対象に攻撃
				Attack(MyID,robbimgEnemy)	-- 攻撃
				AttackedFlag = true		-- 攻撃完了
				Actors[robbimgEnemy].onbattletime = Actors[robbimgEnemy].onbattletime + (GetTick() - GetPreTick)		-- 戦闘時間追加
				AttackFalseTime = GetTick()				-- スタック対策の時間だけ更新
				ReturnFlag = true		--終了
			end
		end
	end
end

-----------------------------------------------------------------------------------------------
-- 特定の敵から逃げる関数
-----------------------------------------------------------------------------------------------
function EscapeFromDanger(enemys)
	local nearest = 0
	nearest = GetNearActorID(MyID,enemys)		-- 一番近い相手
	
	if GetV(V_TARGET,nearest) == MyID then
		if GetDistance2(MyID,nearest) < EscapeRange then			-- ターゲットが自分かつ距離が近い
			MoveBackward (nearest,EscapeRange)
			--TraceAI(" Away From Danger !!!")
			eInfo.awaying = true
		end
	else
		eInfo.awaying = false
	end
end
-----------------------------------------------------------------------------------------------
-- 戦闘中ターゲットを変更する関数
-----------------------------------------------------------------------------------------------
function ChangeTarget(id)
	if IsPlayer(id) == 1 or IsHomunculus(id) == 1 then			-- id がプレイヤーまたはホムンクルスの時
		local target = GetV(V_TARGET,id)			-- すでに消えたIDはIsMonster==0
		if target > 0 and IsMonster(target) == 1 and GetDistance2(MyOwner,target) < 4 and MyEnemy ~= target and ActorInfo(target,"m","act") >= ACT_NORMAL then
			local preRank = MathThreshold(ActorInfo(target,"m","rank"),20) + AddPriority(id)		-- ターゲットの優先度
			local nowRank = 0
			local nID = GetV(V_HOMUNTYPE,MyEnemy)
			if nID > 0 then
				nowRank = MathThreshold(ActorInfo(MyEnemy,"m","rank"),20) + AddPriority(MyEnemy)	-- 現在の敵の優先度
			end
			if nowRank <= 15 or nowRank <= preRank then		-- 優先度15以下なら
				ResetEnemy()
				MyEnemy = target
				GoAttack()
				PrintMessage(MyState,MyEnemy,0,0,0)
			end
		end
	elseif id > 0 and IsMonster(id) == 1 then				-- idがMobの時はidをターゲット
		if MyEnemy ~= id and ActorInfo(id,"m","act") >= ACT_NORMAL then
			ResetEnemy()
			MyEnemy = id
			GoAttack()
			PrintMessage(MyState,MyEnemy,0,0,0)
		end
	end
end
-----------------------------------------------------------------------------------------------
-- 個別優先度を加算する関数
--  idのターゲットが自分または主人のとき、フラグが立っていれば個別優先度+10
-----------------------------------------------------------------------------------------------
function AddPriority(id)
	local target = GetV(V_TARGET,id)
	
	if target == MyID and PriorityME_Flag then
		return 10
	elseif target == MyOwner and PriorityOE_Flag then
		return 10
	else
		return 0
	end
end

-----------------------------------------------------------------------------------------------
-- 共闘ボーナスをチェックする関数
-----------------------------------------------------------------------------------------------
function CheckBonus(enemy)
	if eInfo.battletime > 0 then			-- 共闘モードの際
		local bonus_check = false
		if OurEnemysCount < BonusBorder then
			local nbt = GetTick() - eInfo.battletime		-- 現在の戦闘時間
			local abt = ActorInfo(enemy,"m","record")
			if BonusTimeRate > 0 and abt > 0 then						-- 割合設定
				if nbt > abt*(BonusTimeRate/100) then		-- 平均戦闘時間のN％
					bonus_check = true
				end
			else
				if nbt > BonusTime then
					bonus_check = true
				end
			end
		end
		if bonus_check then
			if ActorInfo(enemy,"m","rank") >= 1 then
				if ActorInfo(enemy,"m","rank") > 20 then
					BonusFlag = true
					return true
				end
			elseif BonusMode then
				BonusFlag = true
				return true
			else
				BonusFlag = false
				return false
			end
		else
			BonusFlag = false
			return false
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------
-- 攻撃状態に移る命令関数
-----------------------------------------------------------------------------------------------
function GoAttack()
	MyState = ATTACK_ST
	AttackFalseTime = GetTick()
end
-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// --

-- 攻撃中に関する定義

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function OnATTACK_ST ()

	--TraceAI ("OnATTACK_ST")
	eInfo.AttackStCycle = Nilpo(eInfo.AttackStCycle) +1									-- ATTACK_STが回った回数
	
	if FollowOwnerTargetting and not eInfo.guardowner then				-- 主人のターゲットを追従
		ChangeTarget(MyOwner)
	end	
	CheckEnemy(OurEnemys,OurEnemysCount)			-- 敵への行動チェック
	
	local enemyData = ActorInfo(MyEnemy)		-- MyEnemyのデータ取得
	
	-- 敵IDと数管理およびトリガー発動
	if MathMod(eInfo.AttackStCycle,3) == 1 then							-- サイクルの3回に1回で
		OurEnemys = GetOurEnemys(Enemys)
		local count = TableSize(OurEnemys)
		if OurEnemysCount ~= count then			-- 戦闘開始または敵の数が変わるたびに
			if count >= EnemyBorder_N then
				TriggerControl("MANY_ENEMYS",TRIGGER_PING,MANY_ENEMYS,MyEnemy)				-- トリガーチェック
			end
		end
		OurEnemysCount = count
		if eInfo.AttackStCycle == 1 then
			local rec = enemyData.m.record
			if rec > EnemyBorder_T then
				TriggerControl("TOUGH_ENEMY",TRIGGER_PING,TOUGH_ENEMY)				-- トリガーチェック
			end
		end
	end
	
	local od = GetDistance2(MyID,MyOwner)				-- 主人と自分の距離
	if od > OnBattleDistance then		-- 戦闘中、指定距離以上ケミが離れた場合、それに追従
		MoveToNear(MyOwner,ChaseDistance)
		ResetEnemy()
		MyState = FOLLOW_ST
		return
	elseif enemyData.hook == 1 and GetV(V_TARGET,MyEnemy) == MyID and od > AttackDistance then
		MyState = HOOK_ST
		return
	end
	
	local ed = GetDistance2(MyID,MyEnemy)
	if HateOverlap and not SPR_Flag and not eInfo.awaying then
		if ( ed == 0 or od == 0) or eInfo.overlapped then
			if OverlapFlag < AwayCount and Nilpo(eInfo.battletime) > 0 then
				AvoidOverlap()				-- 戦闘時，敵か主人と座標が被った場合は移動
				return
			end
		elseif OverlapFlag == AwayCount then		-- 重なってなければ
			OverlapFlag = 0							-- フラグリセット
		end
	end
	
	local motion = enemyData.motion
	--local i_motion = GetV(V_MOTION, 100000 - MyEnemy)
	if motion == MOTION_DEAD or motion == -1 then  	-- 攻撃対象が死んだとき
		KnockOutMob(MyEnemy)
		--TraceAI ("ATTACK_ST -> IDLE_ST")
		--ここで一旦索敵してみる
		SearchEnemy()
		return
	end
	
	if IsOutOfSight(MyID,MyEnemy) then				-- 敵が索敵範囲外に出たとき
		ResetEnemy()								-- 敵情報をリセット
		return 
	end
	
	if eInfo.awaying or ReturnFlag then					-- 退避対象敵が居る場合
		return
	end
	
	if not IsNotNoManner(MyID, MyEnemy) and not eInfo.manualattack then		-- 横殴りチェック
		ResetEnemy()
		return
	end
	
	if ed > AttackDistance and not eInfo.onmove then  	-- 敵が攻撃射程外に出たとき
		MyState = CHASE_ST								-- 追跡状態へ
		MoveToNear(MyEnemy,AttackDistance)
		--TraceAI ("ATTACK_ST -> CHASE_ST  : ENEMY_OUTATTACKSIGHT_IN")
		return
	end
	
	if Nilpo(eInfo.battletime) == 0 then
		eInfo.battletime = GetTick()		-- 戦闘時間計測開始
	end
	
	if CheckBonus(MyEnemy) then		-- 共闘チェック
		return
	end
	
	-- 通常攻撃
	if IsMonster(MyEnemy) == 1 and not eInfo.onmove then
		if not eInfo.onlyskill or (ed <= 2 and SkillDelay > GetTick()) then
			Attack(MyID,MyEnemy)	-- 攻撃
			AttackedFlag = true		-- 攻撃完了
			if MovingCancel then
				--local nx,ny = GetV(V_POSITION,MyID)
				--Move(MyID,nx,ny)		-- ゼロ移動
				--Attack(MyID,MyEnemy)	-- 攻撃
				local nx,ny = GetV(V_POSITION,MyOwner)
				Move(MyID,nx,ny)		-- ゼロ移動 ※20111025仕様変更対策
				Attack(MyID,MyEnemy)	-- 攻撃
				
			end
		end
	end
	eInfo.onmove = false
	-- +++ オートスキル +++ --
	if UseAutoSkill(MyID,MyEnemy) == 1 then
		AttackedFlag = false
		return
	end
	
	-- +++ 自動友達登録 +++ --
	AutoAddFriend()
	
	PrintMessage(MyState,MyEnemy)
end

-------------------------------------------------------------------------
-- Mobを倒した判定をする
-------------------------------------------------------------------------
function KnockOutMob(v)
	if v < 100000 and Actors[v] then								-- 対象がMobなら
		Actors[v]:kill()			-- このMobを倒した
		LostEnemy = v
		LostTime = GetTick()
		--TraceAI (" ! LostEnemy : "..LostEnemy)
	end
	ResetEnemy()									-- 敵情報をリセット
	--TraceAI ("ATTACK_ST -> IDLE_ST")
end

-------------------------------------------------------------------------
-- 平均戦闘時間を記録する
-------------------------------------------------------------------------
function SaveBattleTime(ac)
	if not RecordBattleTime or eInfo.awaying then	-- 記録なし設定もしくは逃亡中
		return
	end
	local enemy = ac.type
	local diftime = ac.onbattletime
	if enemy > 0 then
		if diftime < 60000 then
			if KillCount[enemy] == nil then												-- 今日初めて戦う相手なら
				KillCount[enemy] = 1
				DistTime[enemy]	= diftime
			else
				KillCount[enemy] = KillCount[enemy] + 1
				DistTime[enemy]	= DistTime[enemy] + diftime
			end
		else
			return
		end
		
		--TraceAI(" -- Dist : "..enemy.."   KillCount :"..KillCount[enemy].."  TotalTime : "..DistTime[enemy])	
		local kc = KillCount[enemy]
		if MathMod(kc,RecCount) == 0 then													-- 剰余計算．10回ごとに集計
			if ac.m.record == 0 then						-- 初めて記録される場合
				Mob[enemy][M_RECORD] = math.floor(DistTime[enemy] / KillCount[enemy])
			else																				-- 
				Mob[enemy][M_RECORD] = math.floor((Mob[enemy][M_RECORD] + (DistTime[enemy] / KillCount[enemy]))/2)	-- 前回の記録と足して2で割る
			end
			if Mob[enemy][M_RECORD] > 60000 then								-- 60秒以上の記録は無効
				Mob[enemy][M_RECORD] = 0
			end
			KillCount[enemy] = nil											-- カウントしなおし
			SaveRecord(MobFilename)							-- 自動保存
			TraceAI(" -- Recoad : "..enemy.."   KillCount :"..kc.."  AverageTime : "..Mob[enemy][M_RECORD])
		end
	end
end


-------------------------------------------
-- 移動命令を受けて移動する状態
-------------------------------------------
function OnMOVE_CMD_ST ()

	TraceAI ("OnMOVE_CMD_ST")

	local x, y = GetV (V_POSITION,MyID)
	local ox, oy = GetV (V_POSITION,MyOwner)
	if (x == MyDestX and y == MyDestY) then				-- DESTINATION_ARRIVED_IN
		if MoveToStay then
			ResetEnemy()
			MyState = FOLLOW_CMD_ST
			StayFlag = true
		else
			--if ox == OwnerX and oy == OwnerY and GetDistance(x,y,ox,oy) > FollowDistance then
			if GetDistance(x,y,ox,oy) > FollowDistance then
				StayFlag = true
			else
				StayFlag = false
			end
			MyState = LastState
		end
		MyDestX,MyDestY = 0,0			-- 目標地点リセット
		ResetWalk(MyID)		-- 足跡リセット
		return
	end
	Move(MyID,MyDestX,MyDestY)			-- 移動
end

-------------------------------------------
-- Alt+Tで休息状態に居るとき
-------------------------------------------
function OnFOLLOW_CMD_ST ()
	
	--TraceAI ("OnFOLLOW_CMD_ST")
	local d = GetDistance2(MyID,MyOwner)
	if d <= FollowDistance or d > 15 then									-- 指定セル以下の距離なら
		PrintMessage(MyState,0)
		return 
	end
	if MoveDelay < GetTick() and StayFlag==false then
		MoveDelay = GetTick() + DifferentialAccuracy
		MoveToNear (MyOwner, ChaseDistance)																		-- 主人に追従する
		--TraceAI ("FOLLOW_ST -> FOLLOW_ST")
		PrintMessage(FOLLOW_CMD_MOVE_ST,0)
		return
	end
end


-------------------------------------------------------------------------------------------------------------------------------------------

--  主人の敵を取得する関数

-------------------------------------------------------------------------------------------------------------------------------------------
function GetEnemy(enemys)
	if EnemysCount == 0 then
		return 0
	end
	local MaxPoint = 0
	local target = 0
	local preActive = {}
	for id,v in pairs(enemys) do
		local edata = ActorInfo(id)
		local point = 0
		local act = edata.m.act
		local family = edata.type					-- 種族
		local d = GetDistance2(MyOwner,id)					-- 距離
		local m = edata.motion							-- モーション
		local range = OnBattleDistance+AttackDistance		-- 範囲
		local tg = edata.target							-- ターゲット
		
		if d <= range and edata.targetable then			-- 戦闘可能範囲内かつターゲット可能対象なら採点
			if act >= ACT_IGNORE then							-- 無視設定以上の敵なら
				-- 主人が攻撃しているかの判定
				if GetV(V_TARGET,MyOwner) == id and id ~= LostEnemy and IsActiveMotion(MyOwner) == 1 then
					point = point + TargetPriorityRate*TargetPriority[TP_Ow2En]
					preActive[id] = 0
				end
				-- 友達が攻撃しているかの判定
				if FriendsCount > 0 then
					for i,friend in pairs(Friends) do
						if GetV(V_TARGET,friend) == id and id ~= LostEnemy and IsActiveMotion(friend) == 1 then
							local rate = GetFriendRate(FriendPriorityA,friend)
							point = point + (TargetPriorityRate/FriendsCount)*TargetPriority[TP_Fr2En]*rate
							preActive[id] = 0
						end
					end
				end
			end
			if act >= ACT_NORMAL then		-- 基本設定以上の敵
				-- 優先度による判定
				--TraceAI("get data RANK: "..edata.m.rank.."  REC:"..edata.m.record)
				point = point + ( (MathThreshold(edata.m.rank,20)+AddPriority(id))/20)*TargetPriorityRate*TargetPriority[TP_Rank]
				
				-- 平均戦闘時間による判定
				if edata.m.record > 0 then
					point = point + MathABS((RecType*1000 - edata.m.record)/60000)*TargetPriorityRate*TargetPriority[TP_Rec]
				else
					point = point + NoRecEnemy*TargetPriority[TP_Rec]
				end
				-- 距離による判定
				point = point + (((range+1-d)/range)*TargetPriorityRate)*TargetPriority[TP_Dist]
				
				-- 被ターゲットの判定
				if tg == MyOwner then
					point = point + TargetPriorityRate*TargetPriority[TP_En2Ow]
				elseif tg == MyID then
					point = point + TargetPriorityRate*TargetPriority[TP_En2Me]
				elseif IsFriend(tg) == 1 then
					local rate = GetFriendRate(FriendPriorityD,tg)
					point = point + TargetPriorityRate*TargetPriority[TP_En2Fr]*rate
				elseif not preActive[id] then
					range = AdjustActiveRange(TargetDistance) + AttackDistance
					if not ActiveFlag then				-- アクティブではないかつ、先制設定ではない
						if act ~= ACT_RAID then
							point = 0
						elseif not HalfActive then		-- 先制設定かつハーフアクティブではない
							point = 0
						end
					end
					if d >= range then							-- 策的範囲外
						point = 0
					elseif m == MOTION_ATTACK or m == MOTION_ATTACK2 then		-- 攻撃モーション中
						point = 0
					elseif not IsNotNoManner(MyID,id,1) then
						TraceAI("nomanner  on GetEnemy")
						point = 0
					elseif GetPerHP(MyID) <= ActiveHP or GetPerSP(MyID) <= ActiveSP then			-- 指定HP%以下でノンアク
						point = 0
					end
					if point > 0 then				-- ここでポイントがある場合はアクティブ索敵扱い
						preActive[id] = 1			-- アクティブ索敵判定
					end
				end
			end
		end
		--if point > 0 then
		--	TraceAI("ID : "..id.."   family : "..family.."   **Point : "..point.."              ")
		--end
		-- ポイントチェック
		if point > MaxPoint then
			MaxPoint = point
			target = id
		end
	end
	if preActive[target] == 1 then		-- 最終ターゲットにアクティブ索敵の判定があった場合は
		eInfo.onactive = true				-- アクティブ中フラグON
	end
	return target
end

-- ここで定数定義しちゃう
JobCorrect = {}
JobCorrect[13] = 7			-- ナイト騎→徒歩
JobCorrect[21] = 14			-- クルセイダ－騎→徒歩
JobCorrect[4014] = 4008		-- ロードナイト騎→徒歩
JobCorrect[4022] = 4015		-- パラディン騎→徒歩
JobCorrect[4048] = 4047		-- 拳聖融合→通常
JobCorrect[4060] = 4054		-- ルーンナイト転生徒歩→非転生徒歩
JobCorrect[4080] = 4054		-- ルーンナイト非転生騎→非転生徒歩
JobCorrect[4081] = 4054		-- ルーンナイト転生騎→非転生徒歩
JobCorrect[4061] = 4055		-- ウォーロック転生→非転生
JobCorrect[4062] = 4056		-- レンジャー転生徒歩→非転生徒歩
JobCorrect[4084] = 4056		-- レンジャー非転生騎→非転生徒歩
JobCorrect[4085] = 4056		-- レンジャー転生騎→非転生徒歩
JobCorrect[4063] = 4057		-- アークビショップ転生→非転生
JobCorrect[4064] = 4058		-- メカニック転生徒歩→非転生徒歩
JobCorrect[4086] = 4058		-- メカニック非転生騎→非転生徒歩
JobCorrect[4087] = 4058		-- メカニック転生騎→非転生徒歩
JobCorrect[4065] = 4059		-- ギロチンクロス転生→非転生
JobCorrect[4076] = 4066		-- ロイヤルガード転生徒歩→非転生徒歩
JobCorrect[4082] = 4066		-- ロイヤルガード非転生騎→非転生徒歩
JobCorrect[4083] = 4066		-- ロイヤルガード転生騎→非転生徒歩
JobCorrect[4074] = 4067		-- ソーサラー転生→非転生
JobCorrect[4075] = 4068		-- ミンストレル転生→非転生
JobCorrect[4076] = 4069		-- ワンダラー転生→非転生
JobCorrect[4077] = 4070		-- 修羅転生→非転生
JobCorrect[4078] = 4071		-- ジェネティック転生→非転生
JobCorrect[4079] = 4072		-- シャドーチェイサー転生→非転生

-----------------------------------
-- 友達優先度取得関数
-- list	: FriendPriorityA(攻撃),FriendPriorityD(防御)のどちらかが入る
-- v	: 友達のid
-----------------------------------
function GetFriendRate(list,v)
	local id = GetV(V_HOMUNTYPE,v)
	if IsHomunculus(id) == 1 then
		id = id + 6000
	elseif IsMercenary(id) == 1 then
		id = id + 7000
	end
	local rate = list[id]
	if rate then				--リストにあればその数値を返す
		return rate
	else
		--無い場合は、同職別IDにデータがあればそっちを返す
		rate = list[Nilpo(JobCorrect[id])]
		if rate then
			return rate
		end
		-- その他補正
		if id >= 4001 and id <= 4007 then		--ハイ1次は通常1次と同じ扱い
			if list[id-4001] then
				return list[id-4001]
			end
		elseif id >= 4023 and id <= 4044 then		-- 養子は成人と同じ扱い
			if list[id-4023] then
				return list[id-4023]
			end
		elseif id == 4045 then	--スパノビ子だけずれてるので個別に
			if list[23] then
				return list[23]
			end
		end
		return 1
	end
end

---------------------------------------------------------------------------------------------------------------------------------
--  他人との距離からアクティブ索敵範囲を調整する関数
---------------------------------------------------------------------------------------------------------------------------------
function AdjustActiveRange(range)
	local player = GetNearActorID(MyID, Others)											-- 一番近い他人プレイヤー
	if player ~= 0 then																	-- プレイヤーが居たら
		if GetDistance2(GetV(V_OWNER,MyID),player) ~= -1 then										-- -1じゃないときに
			local dist = math.min(GetDistance2(MyID,player),GetDistance2(MyOwner,player))	-- その人と自分又は主人との距離（近いほう
			if dist > LimitRangeDist then													-- 制限した距離以上なら
				if ActiveRange then
					local decRate = TargetDistance*3
					return math.floor(range*(dist/decRate))									-- 索敵距離計算
				end
			else																			-- 制限した距離内だと
				return -15																	-- 索敵しないことに
			end
		end
	end
	return range
end

-------------------------------------------------------------------------------------------------------------------------------------------
--指定したターゲットを持っている相手を返す
function GetTargetActors(argActors, targetID)
	local resultActors		= {}
	local resultActorsIndex	= 0

	for argActorsIndex, actorID in pairs(argActors) do
		if targetID ~= 0 then
			if GetV(V_TARGET, actorID) == targetID then
				resultActorsIndex = resultActorsIndex + 1
				resultActors[resultActorsIndex] = actorID
			end
		else																		-- 対象のターゲットが0（フリーの敵）を探す
			local target = GetV(V_TARGET, actorID)									-- 実際の対象のターゲット取得
			if target == targetID or target == -1 or IsInSight(target)==0 then		-- ターゲットが0か-1，またはターゲットが画面外
				resultActorsIndex = resultActorsIndex + 1
				resultActors[resultActorsIndex] = actorID
			end
		end
	end
	return resultActors
end

-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--主人、自分、友達のいずれかをターゲットしている敵
function GetOurEnemys(argActors)
	local resultActors		= {}
	local resultActorsIndex	= 0

	for actorID, actorV in pairs(argActors) do
		if GetV(V_HOMUNTYPE, actorID) >= 0 and GetV(V_MOTION, 100000 - actorID) ~= MOTION_DEAD then
			if GetV(V_TARGET, actorID) == MyID or GetV(V_TARGET, actorID) == MyOwner then		-- ターゲットが主人か自分
				resultActorsIndex = resultActorsIndex + 1
				resultActors[resultActorsIndex] = actorID
			elseif IsFriend(GetV(V_TARGET, actorID)) == 1 then									-- または、ターゲットIDが友達リストの中にある
				resultActorsIndex = resultActorsIndex + 1
				resultActors[resultActorsIndex] = actorID
			end
		end
	end
	return resultActors
end
-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------
--範囲内の相手を返す
function GetInRangeActors(argActors, argID, argRange)
	local resultActors		= {}
	local resultActorsIndex	= 0
	
	for argActorsIndex, actorID in pairs(argActors) do
		if GetDistance2(actorID, argID) <= argRange then
			resultActorsIndex = resultActorsIndex + 1
			resultActors[resultActorsIndex] = actorID
		end
	end
	
	return resultActors
end

-------------------------------------------------------------------------------------------------------------------------------------------
--テーブルから指定したIDと最短距離の相手を返す
function GetNearActorID(argID, argActors)
	local resultID	= 0		--戻り値
	local min_dis	= 100	--デフォルト比較距離
	local dis		= 100	--対象との距離

	for argActorsIndex, actorID in pairs(argActors) do
		dis =  GetDistance2(argID,actorID)
		if dis ~= -1 and dis < min_dis then
			resultID = actorID
			min_dis = dis
		end
	end
	
	return resultID
end

-------------------------------------------------------------------------------------------------------------------------------------------
--自分を攻撃中の中から一番近い敵を探す
function GetMyEnemyID(dist)
	local ac = Enemys
	local resultEnemyID	= 0

	ac = GetTargetActors(ac, MyID)													--↑のうちターゲットが自分
	ac = GetInRangeActors(ac, MyOwner, dist)									--↑のうちオーナーから指定セル以内
	resultEnemyID = GetNearActorID(MyID, ac)													--↑のうち自分に一番近い

	return resultEnemyID
end


-------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------
-- 逃避方向を計算する（主人からenemyに対して反対方向へdistだけ移動）
-------------------------------------------
function MoveBackward (enemy,dist)			-- ホムを主人の後方に移動させる
	
	if enemy ~= 0 and IsMonster(enemy) == 1 and IsInSight(enemy) == 1 then	-- ターゲットが存在し，かつ画面内
		local ex, ey = GetV(V_POSITION,enemy)		-- 敵の座標
		local ox, oy = GetV(V_POSITION,MyOwner)		-- 主人の座標
		local mx, my = GetV(V_POSITION,MyID)		-- 自分の座標
		local dirX, dirY = 0, 0
		
		dirX, dirY = VectorCheck(ex,ey,ox,oy)
		
		if EscapeDirection ~= 0 and -9 < EscapeDirection and EscapeDirection < 9 then
			dirX, dirY = RotateDirection(dirX, dirY, EscapeDirection)
		end
		
		local x, y = ox + dist*dirX, oy + dist*dirY
		if GetDistance2(MyOwner,enemy) > 0 then			-- 敵と主人が同セル以外で
			if mx ~= x or my ~= y then					-- 現在地と違えば
				Move(MyID,x,y)
			end
		end
	else
		OnFOLLOW_ST()					-- 敵が居ない時はFOLLOW_STと同じ動作
	end
end

-------------------------------------------
-- x1, y1を基点とし，2点間のベクトル計算する
-- nはゆらぎ許可
-------------------------------------------
function VectorCheck(x1,y1,x2,y2,n)
	local vx,vy = 0,0
	local poll = 0
	if n then
		poll = n
	end
	if x1 - x2 > poll then
		vx = -1
	elseif x1 - x2 < -1*poll then
		vx = 1
	end
	if y1 - y2 > poll then
		vy = -1
	elseif y1 - y2 < -1*poll then
		vy = 1
	end	
	
	return vx, vy
end

-------------------------------------------
-- 方向転換
--812
--7*3
--654
-------------------------------------------
function RotateDirection(x,y,rotate)

	local tableX = {0,1,1,1,0,-1,-1,-1}
	local tableY = {1,1,0,-1,-1,-1,0,1}
	local index = 0
	for i,vx in ipairs(tableX) do
		if x == tableX[i] and y == tableY[i] then
			index = i
			break
		end
	end
	
	index = index + rotate
	
	if index > 8 then
		index = index - 8
	elseif index < 1 then
		index = index + 8
	end
	
	return tableX[index], tableY[index]

end
-------------------------------------------
-- 逃避行動状態に関する定義
-------------------------------------------
function OnESCAPE_ST ()
	--TraceAI("ESCAPE_ST ")
	PrintMessage(MyState,0)
	if EscapePattern == 0 then
		local enemy = GetV(V_TARGET,MyOwner)
		MoveBackward (enemy,EscapeRange)
	else
		target = GetMyEnemyID(OnBattleDistance)									-- 自分を攻撃する敵を探す
		if target ~= 0 then
			local dist = math.max(OnBattleDistance,EscapeRange)					-- 距離の広い方
			if GetDistance2(MyID,target) < 3 and GetTick() > MoveDelay then		-- 接敵されたら逃げる
				SetRondo(EscapePattern,EscapeRange)
				Rondo(EscapePattern,EscapeRange)
			elseif GetDistance2(MyID,MyOwner) > dist then						-- 離れすぎたら主人の近くへ
				MoveToNear (MyOwner, ChaseDistance)
			end
		else
			OnFOLLOW_ST()					-- 敵が居ない時はFOLLOW_STと同じ動作
		end
	end
	
	-- 回復したら通常行動に戻る
	if GetPerHP(MyID) >= HomunculusSafetyHP then
		NowRondo = false
		if LastState == FOLLOW_CMD_ST then			-- 休息状態から入った場合は
			MyState = FOLLOW_CMD_ST						-- 休息状態に回帰
			LastState = ESCAPE_ST
			--TraceAI("ESCAPE exit to FOLLOW !!! ")
			return
		else
			--TraceAI("ESCAPE exit to IDLE !!! ")
			MyState = IDLE_ST
		end
		
	end
end

-------------------------------------------------------
-- 移動履歴をリセットするための関数
-------------------------------------------------------
function ResetWalk(id)
	local x, y = GetV(V_POSITION,id)
	local st = Actors[id].step.t
	Actors[id].step = {x=x,x1=x,x2=x,x3=x,y=y,y1=y,y2=y,y3=y,t=st,t1=st,t2=st,t3=st}
end

-------------------------------------------
-- 先行行動状態に関する定義
-------------------------------------------
function OnFORWARD_ST()

	if SearchEnemy() then		-- 索敵
		return
	end
	
	local x, y = GetV(V_POSITION,MyID)
	local f_dirX, f_dirY = 0,0
	local distance = GetDistance2(MyID,MyOwner)
	local motion = Actors[MyOwner].motion
	local ow = Actors[MyOwner].step				-- 主人の足跡配列
	
	if motion ~= MOTION_MOVE and not SPR_Flag then					-- 移動モーションじゃなくなった時
		MyState = IDLE_ST							-- 待機状態に戻る
		StayFlag = true
		return
	else
		--TraceAI("OnFORWARD_ST")
		-- リーフの場合自動緊急回避
		if GetV(V_MOTION,MyOwner) == MOTION_MOVE then
			if UseSlotSkill(MyID,SKILL_FOLLOW) == 1 then
				return
			end
		end
		-- 目的地計算
		local v1x, v1y = 0,0
		local v2x, v2y = 0,0
		local v3x, v3y = 0,0
		v1x, v1y = VectorCheck(ow.x1, ow.y1, ow.x, ow.y)						-- 現在地と前回の位置ベクトル
		v2x, v2y = VectorCheck(ow.x2, ow.y2, ow.x1, ow.y1)			-- 前回の位置と前々回の位置のベクトル
		v3x, v3y = VectorCheck(ow.x3, ow.y3, ow.x1, ow.y1)			-- 前回の位置と前々回の位置のベクトル
		--TraceAI("v1x , v1y = "..v1x..v1y.."  v2x , v2y = "..v2x..v2y)
		f_dirX = (v1x + v2x + v3x)								-- ベクトルの正規化
		f_dirY = (v1y + v2y + v3y)
		local ax = MathABS(f_dirX)
		local ay = MathABS(f_dirY)
		local div = math.max(ax,ay)		-- 大きいほう
		f_dirX = f_dirX/div
		f_dirY = f_dirY/div
		
		--TraceAI("f_dirX , f_dirY = "..f_dirX..f_dirY)
		if Nilpo(f_dirX) == 0 and Nilpo(f_dirY) == 0 then						-- 目的ベクトルが0,0（主人の座標）のときは
			return											-- なにもしないで抜ける
		end
	end
	
	FordirX = ow.x + math.ceil(Nilpo(f_dirX) * ForwardDistance)
	FordirY = ow.y + math.ceil(Nilpo(f_dirY) * ForwardDistance)
	if FordirX == ow.x then FordirX = FordirX + f_dirX end
	if FordirY == ow.y then FordirY = FordirY + f_dirY end
	FordirX, FordirY = AvoidOverlapCell(MyID,MyOwner,FordirX, FordirY)
	if (x ~= FordirX or y ~= FordirY) and (FordirX > 0 and FordirY > 0) then						-- 現在地と目的地が違えば移動
		if not SPR_Flag then
			--debug
			--TraceAI("FORWOED Movin  x:"..FordirX.." y:"..FordirY.."  id:"..tid)
			Move(MyID,FordirX,FordirY)
			PrintMessage(MyState,0)
		end
	end
end
------------------------------------------------------
-- 後衛状態の関数
-- 敵から退避しつつスキル攻撃
------------------------------------------------------
function OnSHOOTING_ST()

	--TraceAI ("OnSHOOTING_ST")
	local HomSP = GetV (V_SP,MyID)
	local target = 0
	local territory = 3
	
	if GetDistance2(MyID,MyOwner) > OnBattleDistance then	-- 離れすぎると状態解除
		ResetEnemy()
		MyState = FOLLOW_ST
		return
	end
	
	if MyEnemy == 0 then
		MyEnemy = GetEnemy(Enemys)							-- 索敵
	end
	-- 敵がいる時
	if MyEnemy ~= 0 then
		local slevel = ShootLevel
		if slevel == 0 then				-- ShootLevelが0だったら
			slevel = ActorInfo(MyEnemy,"m","skill")		-- Mob別設定を取得
			if slevel == 0 or slevel == 6 then				-- 非使用または自動設定ならば
				slevel = 0			-- とりあえず0
			end
		end
		--使用スキル選択
		local ssid = GetSkillFromASbyType({"ATK","BUF"},territory, slevel,MyEnemy)		-- 使用スキル設定
		
		if ssid == -1 then				-- 定義がなかったら
			ShootingMode = false
			return
		end
		
		-- 使用Lvが各スキル設定に依存する場合
		if ssid > 0 and slevel == 0 then
			--固有の設定値
			local satLevel = Nilpo(Skills[ssid].AS_SkillLevel)
			if Skills[ssid].skilltype == "BUF" then			-- 強化スキルの場合
				satLevel = Nilpo(Skills[ssid].BufferLevel)
			end
			if satLevel > 0 and satLevel <= 5 then	-- 固有の設定値
				slevel = satLevel		-- 正常なら設定
			else
				slevel = 5								-- おかしかったらとにかく5で。
			end
		end
		
		local motion = GetV(V_MOTION, MyEnemy)
		local i_motion = GetV(V_MOTION, 100000 - MyEnemy)
		if motion == MOTION_DEAD or motion == -1 or i_motion == MOTION_DEAD then  	-- 攻撃対象が死んだとき
			LostEnemy = MyEnemy	
			ResetEnemy()									-- 敵情報をリセット
			return
		end	
		
		if ssid > 0 then		-- スキルがセットされている
			
			-- SPが限界以下になったら状態解除
			if HomSP < Nilpo(Skills[ssid].sp[slevel]) then
				ResetEnemy()
				MyState = IDLE_ST
				return
			end
			
			--スキルタイプごとに挙動を変更
			if Skills[ssid].skilltype == "ATK" then			-- 攻撃スキルの場合
				-- 距離が遠かったら近づく
				if MoveInRange(Skills[ssid].range[slevel],target) == 1 then
					return
				end
				-- スキル使用
				GoSlotSkill(MyID,ssid,MyEnemy,slevel)
			elseif Skills[ssid].skilltype == "BUF" then			-- 強化スキルの場合
				-- スキル使用
				UseSlotSkill(MyID,ssid,MyEnemy)
			end
			

		end
		if EscapeOnShooting then
			local m_target = GetMyEnemyID(OnBattleDistance)								-- 自分を攻撃する敵を探す
			if m_target ~= 0 then
				if GetDistance2(MyID,m_target) < territory and GetTick() > MoveDelay then	-- 接敵されたら1秒間隔で逃げる
					SetRondo(PatrolPattern,PatrolRange)
					Rondo(PatrolPattern,PatrolRange)
				end
			end
		end
		PrintMessage(MyState,MyEnemy)
	end
end

----------------------------------------------------------
-- オーナーチェンジする関数
----------------------------------------------------------
function ChangeOwner(id)
	local value = 0
	if id then																	-- idの引数がある場合
		if MyOwner ~= GetV(V_OWNER,MyID) then
			MyOwner = GetV(V_OWNER,MyID)
		elseif MyOwner == GetV(V_OWNER,MyID) and (IsPlayer(id) == 1 or IsHomunculus(id) == 1) and IsFriend(id) == 1 then
			MyOwner = id
			value = 1
		end
	else
		if MyOwner == GetV(V_OWNER,MyID) then						-- 引数が無い場合は一番近い友達
			local owner = GetNearActorID(MyID, Friends)
			if owner ~= 0 then
				MyOwner = owner
				value = 1
			end
		else
			MyOwner = GetV(V_OWNER,MyID)							-- ２回目で元の主人に戻る
		end
	end
	PrintMessage(TRIGGER_ST,MyOwner,TRIGGER_CHANGE_OWNER,value,2,1)
	MyState = ALERT_ST											-- 主人の周りを旋回
end

----------------------------------------------------------
-- 指定座標上に居るキャラクターのIDを返す
----------------------------------------------------------
function GetID(dx,dy)

	local ac = GetActors()  -- 画面内のオブジェクト
	local id = 0                -- ID保存用

	for i,v in ipairs (ac) do
		local x,y = GetV(V_POSITION,v)  -- 座標取得
		if (x == dx and y == dy) then   -- クリック地点の対象なら
			id = v                        -- そのIDを保存
			break
		end
	end
	if id ~= 0 then
		local ty = GetV(V_HOMUNTYPE,id)
		TraceAI(" ** GetID : " ..id.."  --Type : "..ty)
	end
	return id
end

----------------------------------------------------------
-- 予約コマンドを利用した登録の関数
----------------------------------------------------------
function ReservedCommand(msg)

	local id
	local dx,dy

	if msg[1] == MOVE_CMD then											-- 移動コマンドの場合は友達登録動作
		dx,dy = msg[2],msg[3]											-- 指定先の座標を取得
		id = GetID(dx,dy)												-- 指定座標上の対象ID取得
		if id == GetV(V_OWNER,MyID) then								-- 主人のセルクリック
			EditControl(ALT_SHIFT_OWNER_CLICK,id)
		elseif id == MyID then											-- 自分のセルクリック
			EditControl(ALT_SHIFT_MY_CLICK,id)
		else															-- 自分以外の誰か
			EditControl(ALT_SHIFT_CELL_CLICK,id)						-- 友達リストに追加
		end
	elseif msg[1] == ATTACK_OBJECT_CMD then							 	-- 攻撃命令コマンドの場合は無視する敵登録動作
		id = msg[2]                 									-- 攻撃対象のID取得
   		dx,dy = GetV(V_POSITION,id)										-- 対象の座標取得
		if MyState == FOLLOW_CMD_ST then							-- Alt+Tによる休息状態なら
			EditControl(ALT_T_SHIFT_CLICK,id)						-- 無視リストに追加
		else														-- それ以外なら
			if GetV(V_MOTION,GetV(V_OWNER,MyID)) == MOTION_SIT then			-- 主人が座ってる時に
				EditControl(ALT_SHIFT_CLICK_SIT,id)					-- 特殊強化対象指定
			else
				EditControl(ALT_SHIFT_CLICK,id)						-- 先制リストに追加
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- 条件発生系コントロール関数
-- action:トリガーアクション	switch:トリガータイプ	argTrigger:行動内容		id:対象ID	x,y:座標	count:条件数値

-----------------------------------------------------------------------------------------------------------------------------------------------------
function TriggerControl(action,switch,argTrigger,id,x,y,count)
	for i,trigger in ipairs(argTrigger) do
		tActions[trigger](action,switch,T_FLAG[action..trigger],id,x,y,count)
	end	
end

-------------------------------------
-- トリガーコントロールの関数定義
-- switch:トリガータイプ	flag：スイッチフラグ
--------------------------------------
tActions = {}
--スイッチ判定関数
function TriggerSwitchOn(switch,flag)
	if switch == TRIGGER_ON and not flag then
		return true
	else
		return false
	end
end
function TriggerSwitchOff(switch,flag)
	if switch == TRIGGER_OFF and flag then
		return true
	else
		return false
	end
end
-------------------------------------
-- スイッチ関数
--------------------------------------
function T2F(flag)
	if flag then
		return false
	end
	return true
end
----------------------------
--*-- 退避状態になる関数
----------------------------
tActions[TRIGGER_OnESCAPE] = function(action,switch,flag,id,x,y,count)
	if switch == TRIGGER_ON then
		if MyState~=MOVE_CMD_ST then
			if MyState==FOLLOW_CMD_ST then LastState = MyState end
			--TraceAI(" last state  : "..LastState)
			ResetEnemy()
			MyState = ESCAPE_ST
			T_FLAG[action..TRIGGER_OnESCAPE] = true
		end
	elseif TriggerSwitchOff(switch,flag) then
		if LastState==FOLLOW_CMD_ST then 
			MyState = LastState
			LastState = ESCAPE_ST
		end
		T_FLAG[action..TRIGGER_OnESCAPE] = false
		TraceAI("exit escape ...")
	elseif switch == TRIGGER_PING then
		LastState = MyState
		MyState = ESCAPE_ST
	end
end
----------------------------
--*-- 探索行動の関数
----------------------------
tActions[TRIGGER_OnSEARCH] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		MyState = SEARCH_ST
		T_FLAG[action..TRIGGER_OnSEARCH] = true
		TraceAI("search on ...")
	elseif TriggerSwitchOff(switch,flag) then
		T_FLAG[action..TRIGGER_OnSEARCH] = false
		TraceAI("search off ...")
	elseif switch == TRIGGER_PING then
		MyState = SEARCH_ST
	end
end
----------------------------
--*-- 先行移動行動の関数
----------------------------
tActions[TRIGGER_OnFORWARD] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		OnForward = T2F(OnForward)
		T_FLAG[action..TRIGGER_OnFORWARD] = true
	elseif TriggerSwitchOff(switch,flag) then
		OnForward = T2F(OnForward)
		T_FLAG[action..TRIGGER_OnFORWARD] = false
	elseif switch == TRIGGER_PING then
		OnForward = T2F(OnForward)
	end
end
----------------------------
--*-- 援護射撃モード切替の関数
----------------------------
tActions[TRIGGER_OnSHOOTING] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		ShootingMode = T2F(ShootingMode)
		T_FLAG[action..TRIGGER_OnSHOOTING] = true
	elseif TriggerSwitchOff(switch,flag) then
		ShootingMode = T2F(ShootingMode)
		T_FLAG[action..TRIGGER_OnSHOOTING] = false
	elseif switch == TRIGGER_PING then
		ShootingMode = T2F(ShootingMode)
	end
end
----------------------------
--*-- アクティブ切替の関数
----------------------------
tActions[TRIGGER_ACTIVE] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		ActiveFlag = T2F(ActiveFlag)
		T_FLAG[action..TRIGGER_ACTIVE] = true
	elseif TriggerSwitchOff(switch,flag) then
		ActiveFlag = T2F(ActiveFlag)
		T_FLAG[action..TRIGGER_ACTIVE] = false
	elseif switch == TRIGGER_PING then
		ActiveFlag = T2F(ActiveFlag)
	end
end
----------------------------
--*-- オーナー切替の関数
----------------------------
tActions[TRIGGER_CHANGE_OWNER] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		ChangeOwner()
		T_FLAG[action..TRIGGER_CHANGE_OWNER] = true
	elseif TriggerSwitchOff(switch,flag) then
		MyOwner = GetV(V_OWNER,MyID)
		T_FLAG[action..TRIGGER_CHANGE_OWNER] = false
	elseif switch == TRIGGER_PING then
		ChangeOwner(id)
	end
end
----------------------------
--*-- AS発動率上昇の関数
----------------------------
tActions[TRIGGER_ASP_INC] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,eInfo[action..TRIGGER_ASP_INC]) then
		eInfo.addasp = Nilpo(eInfo.addasp) + ASP_Increase
		eInfo[action..TRIGGER_ASP_INC] = true
		TraceAI("ON asp inc : "..eInfo.addasp)
		T_FLAG[action..TRIGGER_ASP_INC] = true
	elseif TriggerSwitchOff(switch,flag) then
		if eInfo[action..TRIGGER_ASP_INC] then eInfo.addasp = Nilpo(eInfo.addasp) - ASP_Increase end
		eInfo[action..TRIGGER_ASP_INC] = false
		T_FLAG[action..TRIGGER_ASP_INC] = false
	elseif switch == TRIGGER_PING then
		eInfo.addasp = Nilpo(eInfo.addasp) + ASP_Increase
	end
end
----------------------------
--*-- AS発動率減少の関数
----------------------------
tActions[TRIGGER_ASP_DEC] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,eInfo[action..TRIGGER_ASP_DEC]) then
		eInfo.addasp = Nilpo(eInfo.addasp) - ASP_Decrease
		eInfo[action..TRIGGER_ASP_DEC] = true
		TraceAI("ON asp dec : "..eInfo.addasp)
		T_FLAG[action..TRIGGER_ASP_DEC] = true
	elseif TriggerSwitchOff(switch,flag) then
		if eInfo[action..TRIGGER_ASP_DEC] then eInfo.addasp = Nilpo(eInfo.addasp) + ASP_Decrease end
		eInfo[action..TRIGGER_ASP_DEC] = false
		T_FLAG[action..TRIGGER_ASP_DEC] = false
	elseif switch == TRIGGER_PING then
		eInfo.addasp = Nilpo(eInfo.addasp) - ASP_Decrease
	end
end
----------------------------
--*-- ASレベル上昇の関数
----------------------------
tActions[TRIGGER_ASL_INC] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,eInfo[action..TRIGGER_ASL_INC]) then
		eInfo.addasl = Nilpo(eInfo.addasl) + ASL_Increase
		eInfo[action..TRIGGER_ASL_INC] = true
		TraceAI("ON asl inc : "..eInfo.addasl)
		T_FLAG[action..TRIGGER_ASL_INC] = true
	elseif TriggerSwitchOff(switch,flag) then
		if eInfo[action..TRIGGER_ASL_INC] then eInfo.addasl = Nilpo(eInfo.addasl) - ASL_Increase end
		eInfo[action..TRIGGER_ASL_INC] = false
		T_FLAG[action..TRIGGER_ASL_INC] = false
	elseif switch == TRIGGER_PING then
		eInfo.addasl = Nilpo(eInfo.addasl) + ASL_Increase
	end
end
----------------------------
--*-- ASレベル低下の関数
----------------------------
tActions[TRIGGER_ASL_DEC] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,eInfo[action..TRIGGER_ASL_DEC]) then
		eInfo.addasl = Nilpo(eInfo.addasl) - ASL_Decrease
		eInfo[action..TRIGGER_ASL_DEC] = true
		TraceAI("ON asl dec : "..eInfo.addasl)
		T_FLAG[action..TRIGGER_ASL_DEC] = true
	elseif TriggerSwitchOff(switch,flag) then
		if eInfo[action..TRIGGER_ASL_DEC] then eInfo.addasl = Nilpo(eInfo.addasl) + ASL_Decrease end
		eInfo[action..TRIGGER_ASL_DEC] = false
		T_FLAG[action..TRIGGER_ASL_DEC] = false
	elseif switch == TRIGGER_PING then
		eInfo.addasl = Nilpo(eInfo.addasl) - ASL_Decrease
	end
end
----------------------------
--*-- 主人の優先度上昇の関数
----------------------------
tActions[TRIGGER_PRIORITY_oENEMY] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		PriorityOE_Flag = true
		T_FLAG[action..TRIGGER_PRIORITY_oENEMY] = true
	elseif TriggerSwitchOff(switch,flag) then
		PriorityOE_Flag = false
		T_FLAG[action..TRIGGER_PRIORITY_oENEMY] = false
	elseif switch == TRIGGER_PING then
		PriorityOE_Flag = true
	end
end
----------------------------
--*-- 自分の優先度上昇の関数
----------------------------
tActions[TRIGGER_PRIORITY_mENEMY] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		PriorityME_Flag = true
		T_FLAG[action..TRIGGER_PRIORITY_mENEMY] = true
	elseif TriggerSwitchOff(switch,flag) then
		PriorityME_Flag = false
		T_FLAG[action..TRIGGER_PRIORITY_mENEMY] = false
	elseif switch == TRIGGER_PING then
		PriorityME_Flag = true
	end
end
----------------------------
--*-- 特定位置へ移動の関数
----------------------------
tActions[TRIGGER_OnMOVE] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) or switch == TRIGGER_PING then
		local x,y = GetV(V_POSITION,MyOwner)
		local mx,my = GetV(V_POSITION,MyID)
		if (T_MoveDirection[1] + x) ~= mx and (T_MoveDirection[2] + y) ~= my then		--目標点と現在点が違えば
			if MyState ~= MOVE_CMD_ST then
				LastState = MyState
			end
			MyState = MOVE_CMD_ST
			MyDestX = T_MoveDirection[1] + x
			MyDestY = T_MoveDirection[2] + y
			Move(MyID,MyDestX,MyDestY)
			ReturnFlag = true
		end
		if switch == TRIGGER_ON then
				T_FLAG[action..TRIGGER_OnMOVE] = true
		end
	elseif TriggerSwitchOff(switch,flag) then
		T_FLAG[action..TRIGGER_OnMOVE] = false
	else
		return
	end
end
----------------------------
--*-- 休息状態になる関数
----------------------------
tActions[TRIGGER_FOLLOW_CMD_ST] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) or switch == TRIGGER_PING then
		ResetEnemy()
		MyState = FOLLOW_CMD_ST
		T_FLAG[action..TRIGGER_FOLLOW_CMD_ST] = true
	elseif TriggerSwitchOff(switch,flag) then
		MyState = IDLE_ST
		T_FLAG[action..TRIGGER_FOLLOW_CMD_ST] = false
	elseif switch == TRIGGER_PING then
		ResetEnemy()
		MyState = FOLLOW_CMD_ST
		return
	end
end

----------------------------
--*-- モードチェンジの関数
----------------------------
tActions[TRIGGER_CHANGE_MODE] = function(action,switch,flag,id,x,y,count)
	if TriggerSwitchOn(switch,flag) then
		ShiftMode(SettingList)
		T_FLAG[action..TRIGGER_CHANGE_MODE] = true
	elseif TriggerSwitchOff(switch,flag) then
		ShiftMode(SettingList)
		T_FLAG[action..TRIGGER_CHANGE_MODE] = false
	elseif switch == TRIGGER_PING then
		ShiftMode(SettingList)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 登録操作系コントロール関数
-- edit:編集内容	id:登録対象
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EditControl(edit,actor,inc)
	if edit == EDIT_FRIEND then
		if IsPlayer(actor) == 1 and actor ~= GetV(V_OWNER,MyID) then			-- IDが主人以外のプレイヤー
			AddFriend(actor)													-- 友達リストに追加
		elseif IsHomunculus(actor) == 1 and actor ~= MyID then					-- IDが自分以外のホムンクルス
			AddFriend(actor)													-- 友達リストに追加
		end
	elseif edit == EDIT_SKILL then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			AddNoSkill(actor)
		end
	elseif edit == EDIT_SKILL_LEVEL then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			if inc then
				ControlSkillLevel(actor,inc)
			else
				ControlSkillLevel(actor,0)
			end
		end
	elseif edit == EDIT_IGNORE then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			AddIgnore(actor)
		end
	elseif edit == EDIT_RAID then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			AddRaid(actor)
		end
	elseif edit == EDIT_SKILLT then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			EditSkillTable(actor)
		end
	elseif edit == EDIT_CAST then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			AddCast(actor)
		end
	elseif edit == EDIT_RANK then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			local id = ActorInfo(actor,"type")
			local rank = Mob[id][M_RANK]
			if rank >= 0 then 
				if rank < 20 then										-- 優先度が最大未満なら
					Mob[id][M_RANK] = rank + 1							-- 優先度+1
				elseif rank > 20 then
					Mob[id][M_RANK] = rank - 20
				end
			end
			SaveRecord(MobFilename)
		end
	elseif edit == EDIT_BONUS then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			local id = ActorInfo(actor,"type")
			local rank = Mob[id][M_RANK]								-- 対象の優先度記録	
			if rank then
				if rank > 0 then
					if rank <= 20 then
						Mob[id][M_RANK] = 20 + rank							-- 優先度反転
					else
						Mob[id][M_RANK] = rank - 20							-- 優先度反転
					end
				else
					Mob[id][M_RANK] = 21
				end
			end
			SaveRecord(MobFilename)
			PrintMessage(EDIT_ST,actor,EDIT_BONUS,Mob[id][M_RANK],2,1)
		end
	elseif edit == EDIT_FULL_SKILL then
		if IsMonster(actor) == 1 and IsPlayer(actor) == 0 and IsHomunculus(actor) == 0 then
			if inc then
				ControlSkillLevel(actor,inc+6)
			else
				ControlSkillLevel(actor,6)
			end
		end
	elseif  edit == EDIT_FRIEND_ALL then
		AddFriendAll()
	elseif  edit == EDIT_FRIEND_DEL then
		ClearFriendList()
	else
		return
	end
end

-------------------------------------------------------------------------
-- 友達追加・削除
-------------------------------------------------------------------------
function AddFriend (id)

	if IsFriend(id) == 0 then															-- idが友達じゃなかったら追加
		if IsPlayer(id) == 1 then														-- プレイヤーなら
			FriendList[id] = GetV(V_HOMUNTYPE,id)
		elseif IsHomunculus(id) == 1 then												-- ホムなら
			HomFriendList[id] = GetV(V_HOMUNTYPE,id)									-- ホム友達リストに追加
		elseif IsMercenary(id) == 1 then												-- 傭兵なら
			HomFriendList[id] = GetV(V_MERTYPE,id)										-- ホム友達リストに追加	
		end
		SaveFriend()																-- 保存
		Neighbor = 0
		FriendIndex = TableSize(FriendList) + TableSize(HomFriendList)
		TraceAI(" ** Add Friend! : " ..id.."  *Job : "..GetV(V_HOMUNTYPE,id).."  --No."..FriendIndex)
		if MyState ~= ATTACK_ST then								-- 戦闘中の自動追加だったらレスは無し
			Response(1)												-- 追加レスポンス
		end
		PrintMessage(EDIT_ST,id,EDIT_FRIEND,1,2,1)
	else																				-- 既に友達だったら削除
		if IsPlayer(id) == 1 then
			FriendList[id] = nil
		elseif IsHomunculus(id) == 1 then
			HomFriendList[id] = nil														-- ホム友達リストから削除
		elseif IsMercenary(id) == 1 then
			HomFriendList[id] = nil														-- ホム友達リストから削除	
		end
		SaveFriend()																-- 保存
		FriendIndex = TableSize(FriendList) + TableSize(HomFriendList)
		TraceAI(" ** Delete Friend! : " ..id.."  LestMem : "..FriendIndex)
		Response(0)													-- 削除レスポンス
		PrintMessage(EDIT_ST,id,EDIT_FRIEND,0,2,1)
	end
end

-------------------------------------------------------------------------
-- 自動友達登録
-------------------------------------------------------------------------
function AutoAddFriend()
	if AutoFriend then								-- 自動友達登録するなら
		if OthersCount > 0 and Neighbor == 0 then
			local otherPlayers = GetTargetActors(Others, GetV(V_TARGET,MyID))
			Neighbor = GetNearActorID(MyID, otherPlayers)				-- タゲの被ってる人が居たら友達の可能性
			--TraceAI("** Neighbor : "..Neighbor)
		end
		
		if Neighbor ~= 0 then
			local aaf_flag = false
			local k_player = MyOwner
			if GetV(V_TARGET,Neighbor) == GetV(V_TARGET,MyOwner) then
				aaf_flag = true
			elseif FriendsCount > 0 then
				for i,v in pairs(Friends) do
					if (GetV(V_HOMUNTYPE,v) == 18 or GetV(V_HOMUNTYPE,v) == 4019) and IsHomunculus(Neighbor) == 1 then	--友達がケミかクリエで隣人がホムだったら
						if  GetV(V_TARGET,Neighbor) == GetV(V_TARGET,v) then
							aaf_flag = true
							k_player = v
							break			--ループ終了
						end
					end
				end
			end
			if aaf_flag then		-- 友達かもしれない人のターゲットが主人と同じとき
				local n_motion = GetV(V_MOTION,Neighbor)
				local o_motion = GetV(V_MOTION,k_player)
				if (n_motion == MOTION_ATTACK or n_motion == MOTION_ATTACK2 or n_motion == MOTION_SKILL or n_motion == MOTION_CASTING) then
					if (o_motion == MOTION_ATTACK or o_motion == MOTION_ATTACK2 or o_motion == MOTION_SKILL or o_motion == MOTION_CASTING) then
						SameTargetCount = SameTargetCount + 1
					end
				end
			--TraceAI("** count : "..SameTargetCount)			
			else											-- そうじゃなかったら
				Neighbor = 0								-- 勘違いだったってことで
				SameTargetCount = 0
			end
			if SameTargetCount >= TamedDegree then					-- 20回くらい被ってたら
				SameTargetCount = 0
				AddFriend(Neighbor)							-- 友達と認識
			end
		end
	end
end

-------------------------------------------------------------------------
-- 友達のホムを自動登録
-------------------------------------------------------------------------
function AutoHomFriend(homs)
	for i,v in pairs(homs) do
		if not OtherHoms[i] then	-- 前のターンに居なかったホムなら
			local hx, hy = GetV(V_POSITION,v)		--座標調査
			for j,d in pairs(Friends) do				-- 友達リスト検索
				local d_job = FriendList[d]
				if GetV(V_MOTION,d) == MOTION_SKILL and IsAlchemist(d) == 1 then	-- その友達がケミ・クリエでスキルモーション中
					local fx, fy = GetV(V_POSITION,d)		-- 友達の座標
					if hx == fx and hy == fy then		-- 野良ホムと座標が同じなら
						AddFriend(v)						-- 友達登録
						homs[i] = nil
					end
				end
			end
		end
	end
	OtherHoms = homs		--他ホム一覧更新
end

-------------------------------------------------------------------------
-- 画面内に居ないホム友達は登録抹消
-------------------------------------------------------------------------
function CheckHomFriend()
	local num = 0
	local deleted = false
	for i,v in pairs(HomFriendList) do
		if IsInSight(i) == 0 then			-- 画面内に居ない
			HomFriendList[i] = nil			-- 登録抹消
			deleted = true
		else
			num = num + 1
		end
	end
	if deleted then		-- 抹消したものがあったら
		SaveFriend()	-- 保存
	end
	return num				-- ホム友達数を返して終了
end
-------------------------------------------------------------------------
-- 画面内全員友達登録
-------------------------------------------------------------------------
function AddFriendAll()
	
	for i,actorID in pairs(Others) do
		if IsPlayer(actorID) == 1 then
			FriendList[actorID] = GetV(V_HOMUNTYPE,actorID)
		elseif IsHomunculus(actorID) == 1 then
			HomFriendList[actorID] = GetV(V_HOMUNTYPE,actorID)
		elseif IsMercenary(actorID) == 1 then
			HomFriendList[actorID] = GetV(V_MERTYPE,actorID)
		end
	end
	FriendIndex = TableSize(FriendList) + TableSize(HomFriendList)
	TraceAI(" ------------ add all friend !!  number : "..FriendIndex)
	Response(2)
	SaveFriend()
	PrintMessage(EDIT_ST,0,EDIT_FRIEND_ALL,0,2,1)
end

-------------------------------------------------------------------------
-- 友達登録クリア
-------------------------------------------------------------------------
function ClearFriendList()
	FriendList = {}
	HomFriendList = {}
	FriendIndex = 0
	TraceAI(" ////// clear all friend ... ")
	Response(3)
	SaveFriend()
	PrintMessage(EDIT_ST,0,EDIT_FRIEND_DEL,0,2,1)
end

-------------------------------------------------------------------------
-- 無視する敵追加・削除
-------------------------------------------------------------------------
function AddIgnore (id)
	local index = GetV(V_HOMUNTYPE,id)										-- 種族IDを取得
	local act = Actors[id].m.act
	if act >= ACT_NORMAL then
		Actors[id].m.act = ACT_IGNORE
		Mob[index][M_ACT] = ACT_IGNORE
		Mob[index][M_RANK] = 0												-- 優先度設定を初期化
		TraceAI(" // Ignore Mob! : " ..index)
		Response(1)
	elseif act == ACT_IGNORE then
		Actors[id].m.act = ACT_NO
		Mob[index][M_ACT] = ACT_NO											-- 完全無視敵
		TraceAI(" // NoRegard Mob! : " ..index)
		Response(2)
	elseif act == ACT_NO then
		Actors[id].m.act = ACT_ESCAPE
		Mob[index][M_ACT] = ACT_ESCAPE										-- 退避対象
		TraceAI(" // Escape Mob! : " ..index)
		Response(3)	
	else																	-- それ以外は通常判定に
		Actors[id].m.act = ACT_NORMAL
		Mob[index][M_ACT] = ACT_NORMAL
		TraceAI(" // Normal Mob! : " ..index)
		Response(0)
	end
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_IGNORE,Mob[index][M_ACT],2,1)
end

-------------------------------------------------------------------------
-- 先制する敵追加・削除
-------------------------------------------------------------------------
function AddRaid (id)
	local index = GetV(V_HOMUNTYPE,id)										-- 種族IDを取得
	if Actors[id].m.act ~= ACT_RAID then										-- idが既に登録されてなかったら追加
		Actors[id].m.act = ACT_RAID
		Mob[index][M_ACT] = ACT_RAID
		TraceAI(" // Raid Mob! : " ..index)
		MyState = ALERT_ST
	else																-- 既に登録されてたら削除
		Actors[id].m.act = ACT_NORMAL
		Mob[index][M_ACT] = ACT_NORMAL
		TraceAI(" // Normal Mob! : " ..index)
		Response(0)
	end
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_RAID,Mob[index][M_ACT],2,1)
end

-------------------------------------------------------------------------
-- スキルを使わない敵追加・削除
-------------------------------------------------------------------------
function AddNoSkill (id)
	local index = GetV(V_HOMUNTYPE,id)										-- 種族IDを取得
	if Actors[id].m.skill >= 0 then
		Actors[id].m.skill = SKILL_NO
		Mob[index][M_SKILL] = SKILL_NO
		TraceAI(" // NoSkill! : "..index)
		Response(1)
	else																-- 既に登録されてたら削除
		Actors[id].m.skill = SKILL_AUTO
		Mob[index][M_SKILL] = SKILL_AUTO
		TraceAI(" // UseSkill! : " ..index)
		Response(0)
	end
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_SKILL,Mob[index][M_SKILL],2,1)
end

-------------------------------------------------------------------------
-- 詠唱妨害する敵追加・削除
-------------------------------------------------------------------------
function AddCast (id)
	local index = GetV(V_HOMUNTYPE,id)										-- 種族IDを取得
	if Actors[id].m.cast == CAST_OFF then
		Actors[id].m.cast = CAST_ON
		Mob[index][M_CAST] = CAST_ON
		TraceAI(" // CastMob! : "..index)
		Response(1)
	else																-- 既に登録されてたら削除
		Actors[id].m.cast = CAST_OFF
		Mob[index][M_CAST] = CAST_OFF
		TraceAI(" // CastOff! : "..index)
		Response(0)
	end
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_CAST,Mob[index][M_CAST],2,1)
end

-------------------------------------------------------------------------
-- スキルテーブルを変更する関数
-------------------------------------------------------------------------
function EditSkillTable(id)
	local index = GetV(V_HOMUNTYPE,id)
	if Mob[index][M_SKILLT] < SKILLT_MAXNUM-1 then
		Mob[index][M_SKILLT] = Mob[index][M_SKILLT] + 1
		Actors[id].m.skillt = Mob[index][M_SKILLT]
	else
		Mob[index][M_SKILLT] = SKILLT_DEFAULT
		Actors[id].m.skillt = SKILLT_DEFAULT
	end
	TraceAI(" //--// "..index.."  this mob's SkillTable : "..Mob[index][M_SKILLT])
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_SKILLT,Mob[index][M_SKILLT],2,1)
end
-------------------------------------------------------------------------
-- スキルレベルを変更する関数
-------------------------------------------------------------------------
function ControlSkillLevel(id,level)
	local index = GetV(V_HOMUNTYPE,id)
	local inc = MathMod(level,6)						-- レベル指定があるかどうか
	
	if inc  ~= 0 then
		if Mob[index][M_SKILL] ~= level then
			Mob[index][M_SKILL] = level
		else
			Mob[index][M_SKILL] = SKILL_AUTO					-- 同レベルの入力指定があった場合はデフォルトに
		end
	else
		if level < 6 then
			if Mob[index][M_SKILL] == SKILL_AUTO then				-- デフォルト設定なら
				Mob[index][M_SKILL] = 1
			else
				Mob[index][M_SKILL] = Mob[index][M_SKILL] + 1	-- レベル+1
			end
		else
			if Mob[index][M_SKILL] == 11 then					-- フルフラットLv5なら
				Mob[index][M_SKILL] = SKILL_AUTO				-- デフォ設定に
			else
				Mob[index][M_SKILL] = inc + 7
			end
		end
	end
	--TraceAI(" -->> Static Skill Level : "..Mob[index][M_SKILL].."  Enemy : "..index)
	SaveRecord(MobFilename)
	PrintMessage(EDIT_ST,id,EDIT_SKILL_LEVEL,Mob[index][M_SKILL],2,1)
end
-------------------------------------------------------------------------
-- アラートパフォーマンス
-------------------------------------------------------------------------
function OnALERT_ST()
	TraceAI("OnALERT_ST")
	if MoveDelay < GetTick() then
		if MC_AlertFlag then
			Rondo(MC_AlertPattern,2)
		else
			Rondo(9,1)									-- 主人の周囲を旋回して通知
		end
	end
	if not NowRondo then
		PatrolVector = 0
		MyState = IDLE_ST
		return
	end
end

-------------------------------------------------------------------------
-- レスポンス
-- Yes→主人の1マス左へ移動　No→主人の1マス右へ移動
-------------------------------------------------------------------------
function Response(ans)
	local ow = Actors[MyOwner]
	if ans == 1 then						-- Yes
		Move(MyID,ow.posx-1,ow.posy)
	elseif ans == 0 then					-- No
		Move(MyID,ow.posx+1,ow.posy)
	elseif ans == 2 then
		Move(MyID,ow.posx,ow.posy+1)			-- up
	elseif ans == 3 then
		Move(MyID,ow.posx,ow.posy-1)			-- down
	end
end

-------------------------------------------------------------------------
-- サーチング関数
-------------------------------------------------------------------------
function OnSEARCH_ST()
	TraceAI("OnSEARCH_ST")
	
	if SearchedObject == 0 then
		local objects = GetActors()						-- 画面内オブジェクト取得
		local distance = 12
		for i,v in ipairs(objects) do
			local id = GetV(V_HOMUNTYPE,v)				-- vの種ID取得
			if id >= 1 and id <= 16 then				-- ホムとPCの切り分け
				if v < 100000 then						-- ホムだったら
					if id >= 9 then		--進化
						id = id - 8
					end
					id = id + 6000						-- +6000
				end
			end
			if v ~= MyID and v ~= GetV(V_OWNER,MyID) and IsSearch(TargetObjects,id) == 1 then
				if distance >= GetDistance2(GetV(V_OWNER,MyID),v) then
					SearchedObject = v
					distance = GetDistance2(GetV(V_OWNER,MyID),v)
					MyDestX,MyDestY = GetV(V_POSITION,SearchedObject)		-- 対象の座標取得
				end
			end
		end
	end
	if SearchedObject ~= 0 then
		PrintMessage(TRIGGER_ST,SearchedObject,TRIGGER_OnSEARCH,IsHomunculus(SearchedObject),2,1)
		if MoveDelay < GetTick() then
			Rondo(10,1)									-- 目的地の周囲を旋回して通知
		end
		if not NowRondo then
			MyDestX,MyDestY = 0,0
			PatrolVector = 0
			SearchedObject = 0
			MyState = IDLE_ST
			return
		end
	else
		MyState = IDLE_ST
	end
end

function SkillObject(id,level,skill,obj)
	if skill > 8000 and SkillDelay < GetTick() then
		SkillObjectL(id,level,skill,obj)
		PrintTalkMSG(MyID,skill,level,0)
		return 1			-- 無条件で1返しておく
	end
end

-------------------------------------------------------------------------
-- SPR待ち用関数
-------------------------------------------------------------------------
function WaitUntilSPR()
	if GetPerSP(MyID) < SPR_Rate and MyState ~= CHASE_ST then
		local x,y = GetV(V_POSITION,MyID)
		if MyRestPosX ==x and MyRestPosY == y then
			local pass = os.difftime(os.time(),StayTime)
			if SPR_Wait <= pass and pass < 4 then
				SPR_Flag = true
				PreSP = GetV(V_SP,MyID)
			elseif pass == 4 then
				if GetV(V_SP,MyID) > PreSP then
					SPR_Flag = true
					StayTime = os.time()
				end
			else
				SPR_Flag = false
				if pass > 4 then
					StayTime = os.time()
				end
			end
		else
			SPR_Flag = false
			MyRestPosX,MyRestPosY = x,y
			StayTime = os.time()
		end
	else
		SPR_Flag = false
	end
end

-------------------------------------------------------------------------
-- APSD補正関数
-------------------------------------------------------------------------
function AttackAccelerator(phase)
	if AttackedFlag and MultiAttack >= 2 and not DistanceOver then		-- 攻撃フラグ立ってたら
		if MathMod(Nilpo(eInfo.AttackStCycle),2) == 1 then		-- 攻撃サイクルの2回に1回
			if phase == 3 and Nilpo(eInfo.prob) > 90 and (SkillDelay > GetTick() and SkillDelay-200 < GetTick()) then
				AttackedFlag = false		--パケ詰まり対策で抜ける
				return
			end
			Attack(MyID,MyEnemy)	-- もう1回攻撃しとく
			if MoveDelay < GetTick() then
				local sx,sy = GetV(V_POSITION,MyID)
				local ex,ey = GetV(V_POSITION,MyEnemy)
				local ox,oy = GetV(V_POSITION,MyOwner)
				if MovingCancel and MovingSP < Actors[MyID].spp and MovingHP < Actors[MyID].hpp and GetDistance2(MyID,MyOwner) < 13 then
					HateOverlap = false
					AttackDistance = 1
					local dirX,dirY = 0,0
					local dirX,dirY = VectorCheck(sx,sy,ex,ey)
					if MathABS(sx-ox) > 13 then
						dirX = dirX*-1
					end
					if MathABS(sy-oy) > 13 then
						dirY = dirY*-1
					end
					if dirX == 0 and dirY == 0 then
						dirX,dirY = VectorCheck(sx,sy,ox,oy)
						dirX,dirY = dirX*-1,dirY*-1
					end
					Move(MyID,sx+dirX,sy+dirY)
					Attack(MyID,MyEnemy)
				else
					-- ※20111025負荷対策 ゼロ移動判定変更
					--Move(MyID,sx,sy)
					Move(MyID,ox,oy)
					Attack(MyID,MyEnemy)	-- もう1回攻撃しとく
				end
			end
			if MultiAttack == phase then
				AttackedFlag = false
			end
		else
			AttackedFlag = false
		end
	elseif MultiAttack == 1 then
		AttackedFlag = false
	end
end

-------------------------------------------------------------------------
-- MCh終了アラート用関数
-------------------------------------------------------------------------
function MC_AlertCheck()
	if CheckMyType(MyType,true) == LIF_H or CheckMyType(MyType,true) == HOMU_S then
		local mcsid = GetSkillSlotID("MentalChange")
		local ct = Skills[mcsid]:limitCheck(MyID)			-- 持続時間チェック
		if ct > GetTick() and MentalChangeAlert ~= 0 then			-- メンタルチェンジ中でアラート指定あり
			local res = ct - GetTick()								--MCh 残り時間
			if res > 0 then
				if res <= MentalChangeAlert*1000 then		-- 残り時間がアラート時間を下回ったら
					MyState = ALERT_ST													-- アラート状態にして抜ける
					MC_AlertFlag = true
					return
				end
			end
		else
			MC_AlertFlag = false
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------

-- スタックチェック用関数

--------------------------------------------------------------------------------------------------------------------------------------------------
function CheckStack()

	local mx, my = GetV(V_POSITION,MyID)			-- 自分の位置
	local ox, oy = GetV(V_POSITION,MyOwner)			-- 主人の位置
	-- 移動のスタックチェック
	if (MyState == FOLLOW_ST or MyState == CHASE_ST or MyState == MOVE_CMD_ST or MyState == FOLLOW_CMD_ST) and MoveStackCheck then
		local motion = GetV(V_MOTION,MyID)
		local case = 0
		--移動をずらすフラグがあるとき
		if MoveShift then
			local dx, dy = MyDestX, MyDestY
			if MyState == FOLLOW_ST or MyState == FOLLOW_CMD_ST then
				dx, dy = GetV(V_POSITION,MyOwner)
			elseif MyState == CHASE_ST then
				dx, dy = GetV(V_POSITION,MyEnemy)
			end	
			local ddx = MathABS(mx-dx)
			local ddy = MathABS(my-dy)
			if Nilpo(MoveShift) == 1 then		--目標点をずらしてみるなどする
				if ddx == 0 then				--Y軸のみ移動のとき
					if (ox - mx) > 0 then	--主人の方が→
						dx = dx + 3
					else
						dx = dx - 3
					end
					dy = my
					MoveDelay = GetTick() + 140 * 3
					MoveShiftLog = 1		--xの移動を決定
				elseif ddy == 0 then				--X軸のみ移動のとき
					if (oy - my) > 0 then	--主人の方が↑
						dy = dy + 3
					else
						dy = dy - 3
					end
					dx = mx
					MoveDelay = GetTick() + 140 * 3
					MoveShiftLog = 2		--yの移動を決定
				elseif ddx > ddy then				-- xかyか距離の短い方のみ移動してみるなど
					dx, dy = mx, dy+(dy-my)
					MoveDelay = GetTick() + 140 * math.floor(ddy * 1.5)
					MoveShiftLog = 2		--yの移動を決定
				else
					dx, dy = dx+(dx-mx), my
					MoveDelay = GetTick() + 140 * math.floor(ddx * 1.5)
					MoveShiftLog = 1		--xの移動を決定
				end
				MoveShift = 2
				dx, dy = AvoidOverlapCell(MyID,MyOwner,dx,dy)
				Move(MyID,dx,dy)
				preDestX, preDestY = dx, dy
				TraceAI(" *-*-* MoveShift2".."  ddx:"..ddx.." ddy:"..ddy)
			elseif Nilpo(MoveShift) == 2 then
				if GetTick() > MoveDelay or (mx == preDestX and my == preDestY) then
					MoveShift = 3
					TraceAI(" *-*-* MoveShift3")
				end
			elseif Nilpo(MoveShift) == 3 then
				if MoveShiftLog == 1 then		--xに移動済み
					dx = mx
					MoveDelay = GetTick() + 140 * ddy
				else							--yに移動済み
					dy = my
					MoveDelay = GetTick() + 140 * ddx
				end
				dx, dy = AvoidOverlapCell(MyID,MyOwner,dx,dy)
				Move(MyID,dx,dy)
				preDestX, preDestY = dx, dy
				MoveShift = 4
				TraceAI(" *-*-* MoveShift4")
			elseif Nilpo(MoveShift) == 4 then
				if GetTick() > MoveDelay or (mx == preDestX and my == preDestY) then
					MoveShift = false
					preDestX, preDestY = 0, 0
					StandTime = GetTick()
					LagCheckFlag = GetTick()				-- ラグを疑う
					TraceAI(" *-*-* MoveShift  finish")
				end
			end
			ReturnFlag = true
			return
		end
		if motion == MOTION_MOVE or SPR_Flag then	-- 通常検査。移動モーションが確認できたら
			StandTime = GetTick()			-- 時間更新
			--StackDist = 0					-- 距離初期化
			return
		else
			local pass = GetTick() - StandTime
			if pass >= 1000 and pass < 1500 then				-- 1秒以上1.3秒未満
				case = 1									-- 解消ケース1
			elseif pass >= 1500 then						-- 1.5秒以上
				case = 2									-- 解消ケース2
			end
			if case == 0 then
				return
			elseif case == 1 then
				if MyState == FOLLOW_ST or MyState == FOLLOW_CMD_ST then
					local d = GetDistance2(MyID,MyOwner)
					
					if d > FollowDistance and not StayFlag then		-- 主人から離れてるときに疑う
						CheckLine(ox, oy, 1)							-- 主人までのルートをデッドライン
						local dist = GetDistance2(MyID,MyOwner)
						local dirX, dirY = VectorCheck(mx,my,ox,oy)			-- 主人への方向をチェック
						local ax,ay = GetGreenCell(MyOwner,GlobalMap,dist,dirX,dirY,1)
						if ax ~= 0 and ay ~= 0 then
							Move(MyID,ax,ay)
							TraceAI("-->> prog green cell")
						else
							ax,ay = AvoidOverlapCell(MyID,MyOwner,Actors[MyOwner].step.x2,Actors[MyOwner].step.y2)
							Move(MyID,ax,ay)
							TraceAI("-->> prog owner step 2")
						end
						StackDist = d
						ReturnFlag = true
						TraceAI("-->> Stack on Follow case1")
					else
						StandTime = GetTick()
					end
				elseif MyState == CHASE_ST then
					local ex, ey = GetV(V_POSITION,MyEnemy)
					CheckLine(ex, ey, 1)							-- 敵までのルートをデッドライン
					local dist = GetDistance2(MyID,MyEnemy)
					local dirX, dirY = VectorCheck(mx,my,ex,ey)			-- 敵への方向をチェック
					local ax,ay = GetGreenCell(MyEnemy,GlobalMap,dist,dirX,dirY,1)
					if ax ~= 0 and ay ~= 0 then
						ax,ay = AvoidOverlapCell(MyID,MyOwner,ax,ay)
						Move(MyID,ax,ay)
					else
						local rot = math.random(2)
						if rot == 2 then rot = -1 end
						dirX, dirY = RotateDirection(dirX,dirY,rot)			-- ランダムでどっちかの方向にずらす
						ax,ay = AvoidOverlapCell(MyID,MyOwner,mx+dirX*2,my+dirY*2)
						Move(MyID,ax,ay)
					end
					StackDist = dist
					ReturnFlag = true
					TraceAI("-->> Stack on Chase ?")
				elseif MyState == MOVE_CMD_ST then
					TraceAI("-->> Stack on Move ?")
					MyState = LastState
					CheckLine(MyDestX, MyDestY,1)							-- 目的地までのルートをデッドライン
					StayFlag = false
				end
			elseif case == 2 then
				local d = GetDistance2(MyID,MyOwner)
				if MyState == FOLLOW_CMD_ST and d <= FollowDistance then
					StandTime = GetTick()
					return
				else
					if MyState == MOVE_CMD_ST then
						MyState = IDLE_ST
						return
					end
					MoveShift = 1
				end
				--if mx ~= PrePos.x3 or my ~= PrePos.y3 then
				--	Move(MyID,PrePos.x3,PrePos.y3)
				--end
				StandTime = GetTick()
				TraceAI("-->> Stack ?!")
				ReturnFlag = true
			end
		end
	else
		StandTime = GetTick()							-- それ以外の状態は無関係なので時間だけ更新
		StackDist = 0									-- 距離初期化
		AroundLog = {x=0,y=0,t=0}			--ついでにここで迂回のあれも初期化
	end
	-- 攻撃のスタックチェック
	if AttackFalseCheck then
		if MyState == ATTACK_ST then
			local SkipStack = false			-- スタック脱出フラグ
			local targetMob = ActorInfo(MyEnemy)
			if targetMob == -1 then			-- 対象のActorデータが得られなければ抜け
				return
			end
			if MyEnemy ~= GetV(V_TARGET,MyID) then		-- ターゲットした敵と実際のターゲットの違いを監視（まだ攻撃できてない）
				AttackFalseCount = AttackFalseCount + 1
				if AttackFalseCount > 3 then
					SkipStack = true
					TraceAI("-->> Stack on Attack !!")
					AttackFalseCount = 0
					if NpcCheck(MyEnemy) == 1 then			-- NPCチェック
						return
					end
				end
			else
				AttackFalseCount = 0
			end
			--フルスキルもしくは逃げる場合は抜け
			if eInfo.onlyskill or eInfo.awaying then
				return
			end
			--攻撃に入ったがなんかおかしい場合
			local e_motion = targetMob.motion
			local o_motion = GetV(V_MOTION,MyOwner)
			if not BonusFlag then												-- 共闘ボーナス中ではなく
				if o_motion ~= MOTION_ATTACK or o_motion ~= MOTION_ATTACK2 or o_motion ~= MOTION_CASTING or o_motion ~= MOTION_SKILL then	-- 主人が攻撃モーションじゃない時
					if e_motion == MOTION_DAMAGE or IsPlant(MyEnemy) == 1 then		-- 敵がダメージモーション或いは植物なら
						AttackFalseTime = GetTick()								-- 時間更新
					else
						local pass = GetTick() - AttackFalseTime
						if pass > 3000 then								-- ダメージモーション以外のモーションが2.4秒以上確認されたら
							SkipStack = true
							AttackFalseTime = GetTick()							-- 時間更新
							TraceAI("-->> Stack on Attack ?")
						end
					end
				end
			end
			if SkipStack then
				local ex, ey = GetV(V_POSITION,MyEnemy)
				local dirX, dirY = VectorCheck(mx,my,ex,ey)			-- 自分から敵への方向をチェック
				local x, y = AvoidOverlapCell(MyID,MyOwner,mx+dirX,my+dirY)
				Move(MyID,x, y)							-- 敵の方向へ一歩進んでみる
				if dirX == 0 and dirY == 0 then				-- 同セルなら
					dirX = -1								-- 西に一歩
				end
				MoveDelay = GetTick() + 200
				ReturnFlag = true
				SkipStack = false
				LagCheckFlag = GetTick()
			end
		else
			AttackFalseTime = GetTick()				-- それ以外の状態は無関係なので時間だけ更新
		end
	end
end

-------------------------------------------------------------------------
-- ラグチェック用関数
-------------------------------------------------------------------------
function CheckLag()
	ReturnFlag = true			-- リターンフラグを立てる
	local ac = GetActors()
	for i,v in ipairs(ac) do
		if GetV(V_MOTION,v) ~= MOTION_STAND and GetV(V_MOTION,v) ~= MOTION_SIT and GetV(V_MOTION,v) ~= MOTION_CASTING then	-- 立ちか詠唱以外のモーションが居たら
			LagCheckFlag = false
			ReturnFlag = false															-- リターンフラグを戻す
			--TraceAI("---  Lag  out")
			return
		end
	end
	if GetTick() > LagCheckFlag + 3000 then		--時間経過で一旦戻してみる
		LagCheckFlag = false
	end
	--TraceAI(" !!!  Lag  ???")
end

-----------------------------------------------------------------------------------------------------------------------------------------

-- 周囲オブジェクト分別関数

-----------------------------------------------------------------------------------------------------------------------------------------
function ScanActors()
	-- ※20111025負荷対策 スキャン回数を減らす・6～7回/sec →　4回/sec
	if GetTick() - ScannedTick < ScanningTime then
		return
	end
	Enemys = {}							-- 敵リスト
	Friends = {}						-- 友達リスト
	Others = {}							-- 他プレイヤーリスト
	Npc = {}							-- NPCリスト
	EnemysCount = 0						-- 敵カウンタ
	FriendsCount = 0					-- 友達カウンタ
	OthersCount = 0						-- 他プレイヤーカウンタ
	NpcCount = 0						-- NPCカウンタ
	local ac = GetActors()
	local lostCheck = true				-- ロストチェック
	local Homs = {}						-- ホムチェック
	local HomsCount = 0					-- ホムカウント
	
	-- まずActor配列をチェック
	for i,v in pairs(Actors) do
		v:scan()		-- 一通り更新
	end
	
	-- 画面内チェック
	for i,v in ipairs(ac) do
		local id = GetV(V_HOMUNTYPE,v)
		if v > 0 and id > 0 then
			
			MakeActor(v)				-- 新規の場合Actorオブジェクト作成
			
			if v == MyID then
				Actors[v].category = "ME"
			elseif v == GetV(V_OWNER,MyID) then
				Actors[v].category = "OWNER"
			elseif IsMonster(v) == 1 then
				Enemys[v] = v
				EnemysCount = EnemysCount + 1
			elseif IsFriend(v) == 1 then
				Friends[v] = v
				FriendsCount = FriendsCount + 1
			elseif IsPlayer(v) == 1 or IsMercenary(v) == 1 then
				Others[v] = v
				OthersCount = OthersCount + 1
			elseif IsHomunculus(v) == 1 then			--ホム
				Others[v] = v
				OthersCount = OthersCount + 1
				Homs[v] = v
			elseif id >= 100 and id <= 1000 then		-- NPC
				Npc[v] = v
				NpcCount = NpcCount + 1
			else
			end
			if v ~= MyID and IsSamePos(MyID,v) == 1 then		--距離0の相手が居る時
				eInfo.overlapped = true
			else
				eInfo.overlapped = nil
			end
			if v == LostEnemy then	-- 倒した敵がまだ画面にいるとき
				lostCheck = false
			end
			Mapping(v)			-- マップ更新
		end
	end
	if lostCheck then
		LostEnemy = 0
	end
	if FriendsCount > 0 and HomsCount > 0 then		-- 友達と友達未登録ホムがいるとき
		AutoHomFriend(Homs)
	end
	
	ScannedTick = GetTick()
end
------------------------------------------------------------------------------------------------------------------------------------------------

-- Actorsオブジェクトの作成

------------------------------------------------------------------------------------------------------------------------------------------------
function MakeActor(v)
	local t = GetV(V_HOMUNTYPE,v)
	if not Actors[v] and t >= 0 then		-- オブジェクトがない場合14マス以内で
		if IsMonster(v) == 1 or IsMob(v) == 1 then			-- Mob相手なら
			Actors[v] = MobClass.new(v)						-- Mobオブジェクト作成
		else
			Actors[v] = ActorClass.new(v)				-- 一般作成
		end
		Actors[v].scan(Actors[v])			-- 作ったらスキャン
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------

-- Actorsクラスの定義

------------------------------------------------------------------------------------------------------------------------------------------------
Actors = {}			-- Actorオブジェクト用配列
ActorClass = {}
ActorClass.new = function(id)
	local obj = {}
	obj.id = id														-- ID定義
	obj.rid = 100000 - id											-- 反転ID定義
	local x,y = GetV(V_POSITION,id)
	local t = GetTick()
	obj.posx, obj.posy = x,y										-- このIDの現在地
	obj.step = {x=x,x1=x,x2=x,x3=x,y=y,y1=y,y2=y,y3=y,t=t,t1=t,t2=t,t3=t}		-- 移動履歴定義
	obj.poptime = t												-- このIDが画面内に入った時間
	obj.timestamp = t											-- このIDを認識している時間管理
	obj.target = GetV(V_TARGET,id)								-- このIDのターゲット
	obj.motion = GetV(V_MOTION,id)								-- このIDのモーション
	obj.type = GetV(V_HOMUNTYPE,id)								-- このIDの種ID
	obj.category = "ACTOR"										-- このオブジェクトの種別
	obj.npc = false												-- NPC判定
	obj.ismonster = false										-- Mob判定フラグ
	obj.m = { act=3, skill=6, as=0, cast=0, skillt=0, rank=0, record=0, skillc=0 }		-- Mob設定値用配列
	
	obj.hp = 0					-- 主人・自分のみ、HP
	obj.sp = 0					-- 主人・自分のみ、SP
	obj.hpp = 0					-- 主人・自分のみ、HP％
	obj.spp = 0					-- 主人・自分のみ、SP％
	
	if 45 <= obj.type and obj.type <= 999 then			--種IDが45～999
		obj.npc = true			-- これはNPC
	end
	--死体オブジェクト
	if Actors[obj.rid] and (GetV(V_MOTION,obj.rid) == MOTION_DEAD and GetV(V_HOMUNTYPE,obj.rid) == -1) then
		obj.category = "DEAD"
		TraceAI(" Dead Obj :"..obj.id)
	end
	
	-- 情報を更新する関数
	obj.scan = function(self)
		-- 自分か主人の場合はHPSP情報更新
		if self.id == MyID or self.id == GetV(V_OWNER,MyID) then
			self.hp = GetV(V_HP,self.id)
			self.sp = GetV(V_SP,self.id)
			self.hpp = GetPerHP(self.id)
			self.spp = GetPerSP(self.id)
			if self.hpp < 0 then self.hpp = 0 elseif self.hpp > 100 then self.hpp = 100 end
			if self.spp < 0 then self.spp = 0 elseif self.spp > 100 then self.spp = 100 end
		end
		self.target = GetV(V_TARGET,self.id) 		-- ターゲット更新
		self.motion = GetV(V_MOTION,self.id)				-- モーション更新
		-- もしタイプが変更されてたらこのオブジェクトは一旦破棄
		local nt = GetV(V_HOMUNTYPE,self.id)
		if self.type ~= nt and nt ~= -1 and (self.motion ~= MOTION_DEAD and self.category ~= "DEAD") then		-- タイプが変わっているかつ死体ではない
			TraceAI(" *?* polimorfizm !?")
			self:del()
			return false
		end
		local x,y = GetV(V_POSITION,self.id)
		if x ~= -1 and y ~= -1 then						-- 位置情報が取れれば足跡更新
			if x ~= self.posx or y ~= self.posy then
				self.step.x3,self.step.y3 = self.step.x2,self.step.y2
				self.step.t3 = self.step.t2
				self.step.x2,self.step.y2 = self.step.x1,self.step.y1
				self.step.t2 = self.step.t1
				self.step.x1,obj.step.y1 = self.step.x, self.step.y
				self.step.t1 = self.step.t
				self.step.x, self.step.y = x,y
				self.step.t = GetTick()
			end
			self.posx, self.posy = x,y					-- 座標更新
			self.timestamp = GetTick()					-- タイムスタンプ更新
			if self.id == MyOwner then
				if self.timestamp - self.step.t > ACT_NORMAL * 100000 then
					local tt = self.step.t
					if MyState ~= 0 then ResetEnemy() end
					self.step.t, self.step.t1, self.step.t2, self.step.t3 = tt, tt, tt, tt	-- 足跡リセット
					ReturnFlag = true
				end
			end
		else
			if self.timestamp + 10000 < GetTick() then		-- タイムスタンプが10秒以上更新がないならオブジェクト削除
				self:del()
				return false
			end
		end
		return true
	end
	-- このオブジェクトを削除する
	obj.del = function(self)
		Actors[self.id] = nil
		TraceAI("////Del obj  id:"..self.id.."  type:"..self.type.."  at "..GetTick())
	end
	TraceAI("!!--- make obj  id:"..obj.id.."  type:"..obj.type.."  at "..obj.timestamp)
	return obj
end

-- Mobクラス定義
MobClass = {}
MobClass.new = function(id)
	local obj = ActorClass.new(id)					-- Actorクラス継承
	obj.ismonster = true							-- Mob判定フラグ
	obj.targetable = true							-- ターゲット可能かどうかのフラグ管理
	obj.attacked = false							-- 攻撃済みかの管理
	obj.onbattletime = 0							-- 戦闘時間
	obj.killtime = false							-- 倒した時、時間管理
	obj.keeptime = 0								-- ターゲット保留の時間管理
	obj.hook = 0									-- フックフラグ
	obj.hooktime = 0								-- フック動作時間管理
	obj.category = "MOB"							-- このオブジェクトの種別
	--Mob設定
	obj.m = GetMobData(obj.type)					-- mobデータ配列
	--TraceAI("MobSetting on "..obj.type.."  ACT:"..obj.m.act.."  SKILL:"..obj.m.skill.." AS:"..obj.m.as.." CAST:"..obj.m.cast.." SKILLT:"..obj.m.skillt.." RANK:"..obj.m.rank.." REC:"..obj.m.record)
	
	obj.oscan = obj.scan						-- Mob用にscanを再定義
	obj.scan = function(self)					-- Mob用のscan関数
		
		-- 通常のスキャン
		if not self:oscan() then		--delされてたら抜ける
			return
		end
		
		self.m = GetMobData(self.type)					-- mobデータ配列更新
		
		--キープタイム監視
		if self.keeptime > 0 then
			if GetDistance2(self.id,MyID) <= 1 or GetDistance2(self.id,MyOwner) <= 1 then
				self.keeptime = 0				-- 自分か主人が隣のセルに侵入できたらキープタイム解消
			end
		end
		-- ターゲット可否判定をここで更新
		if self.keeptime > GetTick() then					-- ターゲットクールタイム中はターゲットできない
			self.targetable = false
		elseif self.type == -1 then							-- typeIDが取得できないとターゲットできない
			self.targetable = false
		elseif self.motion == MOTION_DEAD or self.category == "DEAD" then			-- 死亡モーションはターゲットできない
			self.targetable = false
		elseif ActorInfo(self.rid,"motion") == MOTION_DEAD then			-- 死亡モーションはターゲットできない
			self.targetable = false
		elseif self.rid == LostEnemy then					-- さっき倒したMobの反転IDはターゲットしない
			self.targetable = false
		elseif self.npc then							-- NPCはターゲットできない
			self.targetable = false
		else
			self.targetable = true
		end
		-- 主人が攻撃してたらターゲット可
		if Actors[MyOwner].target == self.id and Actors[MyOwner].motion == MOTION_ATTACK then
			self.targetable = true
			self.npc = false
			self.category = "MOB"
		end
		if self.target == MyID and self.motion == MOTION_ATTACK then		--自分を攻撃したら
			self.npc = false
			self.category = "MOB"
		end
		
		--デバッグ用
		--if not self.targetable then
			--TraceAI("-----!------- "..self.id.." is un targetable!!!")
		--end
		
		-- 主人のターゲットになっていたら攻撃済みフラグ
		if GetV(V_TARGET,MyOwner) == self.id then
			self.attacked = true
		end
		
		-- 戦闘中なら記録
		if self.id == MyEnemy and (MyState == ATTACK_ST or MyState == SHOOTING_ST) then
			-- 相手の死亡確認
			if self.motion == MOTION_DEAD and self.category ~= "DEAD" then		--死亡モーションでDEAD未定義
				TraceAI("K.O")
				KnockOutMob(self.id)
			else
				self.onbattletime = self.onbattletime + (GetTick() - GetPreTick)		-- 戦闘時間追加
			end
		end
	end
	
	-- このMobを倒した
	obj.kill = function(self)
		if self.id > 50000 then			-- 生きてるMobIDは5万以上
			self.killtime = GetTick()			-- 倒した時間
			if Actors[self.rid] then			-- 画面に反転IDが居たらそれは死体
				Actors[self.rid].category = "DEAD"
				TraceAI(self.rid.." is Dead obj ...........")
			end
			TraceAI("*!* Kill mob  id : "..self.id.." type : "..self.type.."  ontime : "..self.onbattletime.."  at before:"..LostEnemy)
			-- 戦闘記録
			SaveBattleTime(self)			-- 記録
		end
		self:del()		-- オブジェクト削除
	end
	return obj
end
-- Mobデータを取得
function GetMobData(tp)
	if not Mob[tp] then
		Mob[tp] = {3,6,0,0,0,0,0,0,0,0}
		TraceAI("-!- undefined Mob "..tp)
	end
	local m = {}
	m.act = Nilpo(Mob[tp][M_ACT],3)			-- 対応に関する設定
	m.skill = Nilpo(Mob[tp][M_SKILL],6)		-- スキルレベル設定
	m.as = Nilpo(Mob[tp][M_AS],0)				-- AS追加発動率の設定
	m.cast = Nilpo(Mob[tp][M_CAST],0)			-- 詠唱妨害するかの設定
	--m.boost = Nilpo(Mob[tp][M_BOOST],0)		-- 特殊強化するかの設定
	m.rank = Nilpo(Mob[tp][M_RANK],0)			-- 優先度設定
	m.record = Nilpo(Mob[tp][M_RECORD],0)		-- 平均戦闘時間の記録
	m.skillc = Nilpo(Mob[tp][M_SKILLC],0)		-- ASスキル回数の設定
	m.skillt = Nilpo(Mob[tp][M_SKILLT],0)		-- ASスキルテーブルの選択設定
	return m
end
-- Actors配列の情報を取得したい
function ActorInfo(id,n,p)
	local t = GetV(V_HOMUNTYPE,id)
	if not Actors[id] then			-- 配列がなかったら作成
		if t < 0 then				-- 種族IDが取得できない時
			if n == "m" then
				local nm = GetMobData(t)
				if p then
					return nm[p]
				else
					return nm
				end
			else
				return -1
			end
		end
		TraceAI("no definded Mob : id:"..id)
		MakeActor(id)
	end
	if not n then					-- 第2引数がない場合は配列そのまま返す
		return Actors[id]
	elseif n == "m" and p then		-- Mob配列で第3引数がある場合は値を返す（無い場合はMob配列が帰る）
		return Actors[id][n][p]
	end
	return Actors[id][n]
end

-- NPCかどうかチェックする関数
-- ターゲットMobの周囲に透明NPCがいればMobNPC
function NpcCheck(id)
	if NpcCount > 0 then
		local nx,ny = GetV(V_POSITION,id)		-- 対象のポジション
		for i,v in pairs (Npc) do
			if GetDistance2(id,v) <= 1 and ActorInfo(v,"type") == 111 then			-- NPCと対象の距離が1以下で透明NPC
				Actors[id].npc = true			-- NPCフラグ
				ResetEnemy()
				TraceAI(" !!-!!  id:"..id.." is NPC ")
				return 1
			end
		end
	end
	return 0
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- マッピング

------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Mapping(id)
	local x,y = GetV(V_POSITION,id)
	if CheckCell(LocalMap,x,y) == 0 then
		LocalMap[x][y] = id
	end
	
	if CheckCell(GlobalMap,x,y) then
		GlobalMap[x][y] = 1		--キャラが居るセルに1を埋めていく
	end
end
-- セルチェック 未検査：0　進入可：1　進入不可：-1　※LocalMapで1はそこにキャラが居る
function CheckCell(map,x,y)
	if not map[x] then
		map[x] = {}
		return 0
	end
	return Nilpo(map[x][y])
end
-- 進入不可
function DeadCell(x,y)
	if CheckCell(GlobalMap,x,y) == 0 then
		GlobalMap[x][y] = -1		--進入不可は-1
	end
end
-- x,yまでのルートチェック	type… 0:検索 1:デッドライン作成 level…検索時のセルレベル
function CheckLine(x,y,ty,level)
	--local x,y = GetV(V_POSITON,id)
	local mx,my = GetV(V_POSITION,MyID)
	local dx,dy = MathABS(x-mx), MathABS(y-my)			-- 自分とx,yの距離
	local dirX, dirY = VectorCheck(mx,my,x,y)			-- 自分からx,yへの方向をチェック
	if (dx ~= 0 or dy ~= 0) and (dirX ~= 0 or dirY ~= 0) then
		if dx > dy then
			TraceAI("X > Y   distX:"..dx.." distY:"..dy.."  dirX:"..dirX.."  dirY:"..dirY)
			for i=dirX,(dx-1)*dirX,dirX do
				local nx,ny = mx+i,my+(MathRound(MathABS(i)*(dy/dx))*dirY)
				if ty == 0 then
					if CheckCell(GlobalMap,nx,ny) <= level then	--検索セルがレベル以下だったとき
						return false
					end
				elseif ty == 1 then
					DeadCell(nx,ny)		--デッドライン作成
				end
			end
		else
			TraceAI("Y > X   distX:"..dx.." distY:"..dy.."  dirX:"..dirX.."  dirY:"..dirY)
			for i=dirY,(dy-1)*dirY,dirY do
				local nx,ny = mx+(MathRound(MathABS(i)*(dx/dy))*dirX),my+i
				if ty == 0 then
					if CheckCell(GlobalMap,nx,ny) <= level then	--検索セルがレベル以下だったとき
						return false
					end
				elseif ty == 1 then
					DeadCell(nx,ny)
				end
			end
		end
	end
	if ty == 0 then
		return true
	end
end
-- id周囲の最寄の有効セルを探索する
-- map:使用するマップ dist:探索範囲 vx,vy:自分→目的地のベクトル span:指定距離より遠い位置に移動
function GetGreenCell(id,map,dist,vx,vy,span)
	local x,y = GetV(V_POSITION,id)
	if x < 0 or y < 0 then
		return 0,0
	end
	local mx,my = GetV(V_POSITION,MyID)
	local nx,ny = 0,0					-- 返す値
	local nd,md = 16,16					--距離の管理
	if StackDist ~= 0 then md = StackDist end
	if not dist then dist = 15 end		--範囲指定なければ全体
	if not span then span = 1 end		--距離指定なければ1
	local ax,ay = x-dist,y-dist
	local bx,by = x+dist,y+dist
	if vx and vy then							--ベクトルあれば範囲修正
		local b_dist = math.ceil(dist/2)
		if vx > 0 then				--X軸が「自分→目的地」のとき
			ax = ax - 2				-- 自分周辺のX軸検索範囲修正
			bx = x + b_dist			-- 目的地周辺のX軸検索範囲修正
		elseif vx < 0 then			--X軸が「目的地←自分」のとき
			ax = x - b_dist			-- 目的地周辺のX軸検索範囲修正
			bx = bx + 2				-- 自分周辺のX軸検索範囲修正
		end
		if vy > 0 then				--Y軸が「自分↑目的地」のとき
			ay = ay - 2
			by = y + b_dist
		elseif vy < 0 then			--Y軸が「自分↓目的地」のとき
			ay = y - b_dist
			by = by - 2
		end
	end
	-- 経路探索
	TraceAI("range x:"..ax.."-"..bx.."  y:"..ay.."-"..ay.."  span:"..span)
	for j=ay,by,1 do
		for i=ax,bx,1 do
			if CheckCell(map,i,j) == 1 then
				local td = GetDistance(mx,my,i,j)			--自分から地点i,jの距離
				local pd = GetDistance(x,y,i,j)				--目的地と地点i,jの距離
				if not MovedGreen[i] then			--移動記録チェック
					MovedGreen[i] = {}
				end
				if td <= nd and pd < md and td >= span and (i~=x and j~=y) and Nilpo(MovedGreen[i][j]) < GetTick() and CheckLine(i,j,0,-1) then
					nd = td		--距離更新
					md = pd		--距離更新
					nx,ny = i,j
					TraceAI("Search GreenCell =>  "..nx.." "..ny)
					--if nd <= span then return nx,ny end
				end
			end
		end
	end
	TraceAI("GreenCell!! =>  "..nx.." "..ny)
	if not MovedGreen[nx] then
		MovedGreen[nx] = {}
	end
	MovedGreen[nx][ny] = GetTick() + 30000		-- 一旦動いた地点は30秒間凍結する
	return nx,ny
end

-- デバッグ用にマップ出力しちゃう
function OutputMap(map)
	if not mapout then
		local x,y = GetV(V_POSITION,MyID)
		local pr = ""
		for j=15,-15,-1 do
			for i=-15,15,1 do
				if i==0 and j == 0 then
					pr = pr.."★"
				elseif x+i == Actors[MyOwner].posx and y+j == Actors[MyOwner].posy then
					pr = pr.."☆"
				elseif CheckCell(LocalMap,x+i,y+j) > 0 then
					pr = pr.."●"
				elseif CheckCell(map,x+i,y+j) == 1 then
					pr = pr.."□"
				elseif CheckCell(map,x+i,y+j) == -1 then
					pr = pr.."■"
				else
					pr = pr.."　"
				end
			end
			pr = pr.."\n"
		end
		if pr then
			mfp = io.open("AI/MapDeb.txt","w")
			if mfp then
				mfp:write(pr)
				mfp:close()
			end
		end
		mapout = GetTick() + 3000
	elseif GetTick() > mapout then
		mapout = false
	end
end

------------------------------------------------------
-- ステータスチェック
------------------------------------------------------
function StatusCheck(myid)
	-- HP/SP等の取得
	local owner = GetV(V_OWNER,myid)
	local homHP = Actors[myid].hpp
	local homSP = Actors[myid].spp
	local ownerHP = Actors[owner].hpp
	local ownerSP = Actors[owner].spp
	
	--スキル使用後のSP管理
	if beforeSP and CancelSkill and homSP<100 then
		-- キャスティング完了
		if OnCasting <= GetTick() then
			if GetV(V_SP,myid) == beforeSP and Skills[CancelSkill].skilltype ~= "SWT" then
				--local cancel_slotid = GetSkillSlotID(CancelSkill)
				Skills[CancelSkill]:cancel()
				TraceAI(Skills[CancelSkill].name.." skill miss?  Canceled  motion "..GetV(V_MOTION,myid))
			end
			CancelSkill = nil
			beforeSP = nil
		else
			-- キャスティング中は
			TraceAI(Skills[CancelSkill].name.." under casting.....")
			beforeSP = GetV(V_SP,myid)			-- SP値は更新
			if Actors[myid].motion == MOTION_DAMAGE then			-- ダメージを受けていたら
				Skills[CancelSkill]:cancel()
				TraceAI(Skills[CancelSkill].name.." skill Prevented！  skill Canceled")
			end
		end
	elseif useSkill then
		if Skills[useSkill].skilltype ~= "COM" then		-- コンボは例外
			CancelSkill = useSkill
		end
	end
	useSkill = nil
	
	-- 毎サイクルチェック
	-- ホムHPチェック
	if homHP < HomunculusSafetyHP then
		TriggerControl("MY_HP_UNDER_SAFETY",TRIGGER_ON,MY_HP_UNDER_SAFETY)
	else
		TriggerControl("MY_HP_UNDER_SAFETY",TRIGGER_OFF,MY_HP_UNDER_SAFETY)
	end
	
	-- ホムSPチェック
	if homSP < HomunculusSafetySP then
		TriggerControl("MY_SP_UNDER_SAFETY",TRIGGER_ON,MY_SP_UNDER_SAFETY)
	else
		TriggerControl("MY_SP_UNDER_SAFETY",TRIGGER_OFF,MY_SP_UNDER_SAFETY)
	end
	
	-- 主人HPチェック
	if ownerHP < OwnerSafetyHP then
		TriggerControl("OWNER_HP_UNDER_SAFETY",TRIGGER_ON,OWNER_HP_UNDER_SAFETY)
	else
		TriggerControl("OWNER_HP_UNDER_SAFETY",TRIGGER_OFF,OWNER_HP_UNDER_SAFETY)
	end
	
	-- 主人SPチェック
	if ownerSP < OwnerSafetySP then
		TriggerControl("OWNER_SP_UNDER_SAFETY",TRIGGER_ON,OWNER_SP_UNDER_SAFETY)
	else
		TriggerControl("OWNER_SP_UNDER_SAFETY",TRIGGER_OFF,OWNER_SP_UNDER_SAFETY)
	end
	
	--一定サイクルチェック
	if GetTick() - StatusCheckCycle > 1000 then
		if HomHP_Per - homHP >= FallMyHpRate then
			TriggerControl("MY_HP_EMERGENCY",TRIGGER_PING,MY_HP_EMERGENCY)
		end
		if HomSP_Per - homSP >= FallMySpRate then
			TriggerControl("MY_SP_EMERGENCY",TRIGGER_PING,MY_SP_EMERGENCY)
		end
		if OwnerHP_Per - ownerHP >= FallOwnerHpRate then
			TriggerControl("OWNER_HP_EMERGENCY",TRIGGER_PING,OWNER_HP_EMERGENCY)
		end
		if OwnerSP_Per - ownerSP >= FallOwnerSpRate then
			TriggerControl("OWNER_SP_EMERGENCY",TRIGGER_PING,OWNER_SP_EMERGENCY)
		end
		-- HP/SP更新
		HomHP_Per = homHP
		HomSP_Per = homSP
		OwnerHP_Per = ownerHP
		OwnerSP_Per = ownerSP
		StatusCheckCycle = GetTick()
	end
	-- 主人のモーションチェック
	if GetV(V_MOTION,owner) == T_OwnerMotion then
		TriggerControl("OWNER_MOTION",TRIGGER_ON,OWNER_MOTION)
	else
		TriggerControl("OWNER_MOTION",TRIGGER_OFF,OWNER_MOTION)
	end
	-- オート回復スキル
	AutoRecover(myid)
end

------------------------------------------------------
-- HPの％チェック
------------------------------------------------------
function GetPerHP(id)
	local hp = GetV(V_HP,id)
	local mhp = GetV(V_MAXHP,id)
	return (hp/mhp)*100
end

------------------------------------------------------
-- SPの％チェック
------------------------------------------------------
function GetPerSP(id)
	local sp = GetV(V_SP,id)
	local msp = GetV(V_MAXSP,id)
	return (sp/msp)*100
end

------------------------------------------------------
-- 主人との距離チェック
------------------------------------------------------
function CheckDistance()
	local x,y = GetV(V_POSITION,MyID)
	local ox,oy = GetV(V_POSITION,GetV(V_OWNER,MyID))
	
	if MathABS(x - ox) > 12 or MathABS(y - oy) > 12 then		-- 距離が12より多くなったら
		DistanceOver = true
		if MathABS(x - ox) < 15 or MathABS(y - oy) < 15 then	-- 14以内なら
			--if CheckMyType(MyType) ~= AMISTR then		--羊以外は
				MyOwner = GetV(V_OWNER,MyID)							-- 主人を取得しなおして
				ResetEnemy()											-- リセットしつつ
				MoveToNear(MyOwner,1)										-- 主人のセルへ戻る
				ReturnFlag = true										-- リターンフラグ
				--TraceAI(" !! Long distance --------------- Back To Owner.")
			--end
		end
	else
		if IsInSight(MyOwner) == 0 then
			MyOwner = GetV(V_OWNER,MyID)
		end
		DistanceOver = false
	end
end

------------------------------------------------------
-- 自分のタイプチェック
------------------------------------------------------
function CheckMyType(my,high)
	local ty = 0
	if my == LIF or my == LIF_H or my == LIF2 or my == LIF_H2 then
		ty = 1
	elseif my == AMISTR or my == AMISTR_H or my == AMISTR2 or my == AMISTR_H2 then
		ty = 2
	elseif my == FILIR or my == FILIR_H or my == FILIR2 or my == FILIR_H2 then
		ty = 3
	elseif my == VANILMIRTH or my == VANILMIRTH_H or my == VANILMIRTH2 or my == VANILMIRTH_H2 then
		ty = 4
	elseif my == EIRA then
		ty = EIRA
	elseif my == BAYERI then
		ty = BAYERI
	elseif my == SERA then
		ty = SERA
	elseif my == DIETER then
		ty = DIETER
	elseif my == ELEANOR then
		ty = ELEANOR
	end
	if high then		-- 進化後の区別をする場合
		if my == LIF_H or my == LIF_H2 or my == AMISTR_H or my == AMISTR_H2 or my == FILIR_H or my == FILIR_H2 or my == VANILMIRTH_H or my == VANILMIRTH_H2 then
			ty = ty + 8
		elseif my == SERA or my == EIRA or my == ELEANOR or my == BAYERI or my == DIETER then
			ty = HOMU_S
		end
	end
	return ty
end

------------------------------------------------------
-- トーク出力関数
-- actor:種ID case:状況 value:値(内容に応じる) hold:表示時間(秒) トークメッセージは強制的にinter
------------------------------------------------------
function PrintTalkMSG(actor,case,value,hold)
	if PrintTalk then
		PrintMessage(200,actor,case,value,hold,1)
	end
end
------------------------------------------------------
-- メッセージ出力関数
-- state:状態 actor:対象ID case:状況 value:値(内容に応じる) hold:表示時間(秒) inter:1で前回の表示時間をキャンセル(即表示)
------------------------------------------------------
function PrintMessage(state,actor,case,value,hold,inter)
	if PrintMsg and PrintableFlag then
		local pass = os.difftime(os.time(),PrintTimeOut)
		if inter == 1 then
			MsgHoldTime = -1
		end
		if state == msgList[1] and actor==msgList[15] then
			return
		elseif pass > MsgHoldTime then					-- 前回と違う状態になった＆1秒以上経ったらメッセージ更新
			msgList = {-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}				-- リストクリア
			msgList[1] = state
			if state == IDLE_ST then
				if ActiveFlag then msgList[2] = 1 end
				msgList[3] = Actors[MyID].posx
				msgList[4] = Actors[MyID].posy
			elseif state == FOLLOW_CMD_ST then
				msgList[3] = Actors[MyID].posx
				msgList[4] = Actors[MyID].posy
			elseif state == CHASE_ST then
				msgList[2] = GetV(V_HOMUNTYPE,actor)
			elseif state == ATTACK_ST or state == SHOOTING_ST then
				local id = GetV(V_HOMUNTYPE,actor)
				if not Mob[id] then Mob[id] = {} end
				msgList[2] = id															-- 敵の種ID
				if Mob[id][M_ACT] then msgList[3] = Mob[id][M_ACT] else msgList[3] = 3 end					-- 対応
				if Mob[id][M_SKILL] and Skills[SKILL_ATK1] then
					if Mob[id][M_SKILL] == 6 or Mob[id][M_SKILL] == 12 then
						if Skills[SKILL_ATK1].AutoAdjust then msgList[4] = AdjustSkillLevel(id,Skills[SKILL_ATK1].AS_SkillLevel,Skills[SKILL_ATK1].AS_threshold)
						else msgList[4] = Skills[SKILL_ATK1].AS_SkillLevel end
						msgList[4] = msgList[4] + Nilpo(eInfo.addasl)										-- スキルレベル
						if msgList[4] > 5 then msgList[4] = 5 elseif msgList[4] < 0 then msgList[4] = 0 end
					else msgList[4] = Mob[id][M_SKILL] end
				end
				if Mob[id][M_CAST] then msgList[5] = Mob[id][M_CAST] end									-- 詠唱妨害
				if Mob[id][M_SKILLT] then msgList[6] = Mob[id][M_SKILLT] end									-- スキルテーブル
				if Mob[id][M_RANK] then msgList[7] = Mob[id][M_RANK]+AddPriority(MyEnemy) end									-- 優先度
				if Mob[id][M_RECORD] then msgList[8] = Mob[id][M_RECORD] end								-- 記録
				--msgList[9] = math.floor(AutoSkill + Nilpo(Mob[id][M_AS]) + Nilpo(eInfo.addasp)+AspCoefficient*(GetPerSP(MyID)/100)^AspExponential)				-- ASP
				if Skills[SKILL_ATK1] then
					msgList[9] = Skills[SKILL_ATK1].calcprob(Skills[SKILL_ATK1],id)		--攻撃スキルの設定があればASP計算
				end
				if msgList[9] > 100 then msgList[9] = 100 elseif msgList[9] < 0 then msgList[9] = 0 end
				if Mob[id][M_SKILLC] then msgList[11] = Mob[id][M_SKILLC] end								-- 記録
				msgList[15] = actor
			elseif state == EDIT_ST then
				msgList[2] = case						-- 編集内容
				msgList[3] = value						-- 更新データ
				msgList[4] = actor						-- 対象ID
				msgList[5] = GetV(V_HOMUNTYPE,actor)	-- 対象の種ID
				msgList[6] = IsHomunculus(actor)		-- ホムかどうか
			elseif state == TRIGGER_ST then
				msgList[2] = case									-- 編集内容
				msgList[3] = value									-- 更新データ
				msgList[4] = actor									-- 対象ID
				msgList[5] = GetV(V_HOMUNTYPE,actor)				-- 対象の種ID
				msgList[6],msgList[7] = GetV(V_POSITION,actor)		-- 対象の座標
				msgList[8] = IsMonster(actor)						-- 対象は攻撃可能か
			elseif state == MODE_ST then
				msgList[2] = case									-- モード番号
				msgList[3] = actor									-- モードインデックス
			elseif state == 200 then		-- トーク専用
				msgList[2] = case									-- メッセージ内容
				msgList[3] = value									-- メッセージ内容
			elseif state == 201 then		-- タイマーキャンセル
				msgList[2] = case									-- メッセージ内容
				msgList[3] = value									-- メッセージ内容
			end
			msgList[10] = MyType
			local filename = SaveDir.."Message.lua"
			local fp = io.open(filename,"w")
			if fp then
				fp:write(string.format("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", msgList[1], msgList[2], msgList[3], msgList[4], msgList[5], msgList[6], msgList[7], msgList[8], msgList[9], msgList[10], msgList[11], msgList[12], msgList[13], msgList[14], msgList[15]))
				PrintTimeOut = os.time()
				if hold then MsgHoldTime = hold else MsgHoldTime = 0 end
				fp:close()
				PrintableFlag = false			-- 1サイクルで2回以上書き込めない
			end
		end
	end
end

------------------------------------------------------
-- モードシフト関数	number に対応するタイプを読み込む
------------------------------------------------------
function ShiftMode(list)
	local length = TableSize(list)
	if SettingList[ModeIndex] == CheckMyType(MyType) then		-- リストに自分のタイプと同じ番号が含まれていたら
		ModeIndex = ModeIndex +1
	end
	if ModeIndex <= length then
		TraceAI("  Shift !  number :"..SettingList[ModeIndex])
		ChangeMode(SettingList[ModeIndex])
		ModeIndex = ModeIndex +1
	else
		ModeIndex = 0
		local om = CheckMyType(GetV(V_HOMUNTYPE,MyID))
		TraceAI("  Original mode !  number :"..om)
		ChangeMode(om)
		ModeIndex = 1
	end
end

------------------------------------------------------
-- モードチェンジ関数	number に対応するタイプを読み込む
------------------------------------------------------
function ChangeMode(number)
	if number > 0 and number <= 16 then
		if io.open(SaveDir.."Set.lua") then
			local m_filename = MobFilename			-- Mobファイルはそのまま
			MyType = number							-- 自分のタイプを偽装して
			Setting()
			MyType = GetV(V_HOMUNTYPE,MyID)			-- 元に戻す
			MobFilename = m_filename				-- 元に戻す
			PrintMessage(MODE_ST,ModeIndex,number,0,1,1)
		end
	elseif number == 0 then
		Initialize()
	end
end

-- Settingダミー関数
function Setting()
end

-- にるぽ vがnilでnが未設定なら0、nが設定されてたらnを返す
function Nilpo(v,n)
	if v == nil then
		if n == nil then
			return 0
		else
			return n
		end
	else
		return v
	end
end

--AIサイクル上初期化したいもの
function LocalInit()
	ReturnFlag = false
	PrintableFlag = true
	LocalMap = {}
end

------------------------------------------------------
-- 自律行動時のメインルーチン
------------------------------------------------------
function AImain(myid)

	MyID = myid
	LocalInit()			--AIサイクル上初期化したいもの
	if InitialFlag then
		Initialize()
		LoadRecord(MobFilename)							-- 戦闘記録読み込み
		ResetWalk(myid)
		local t = LoadTimeKeep()									-- Timeファイル読み込み
		PrintMessage(t,0,0,0,0,1)					-- ロードメッセージ
		-- この設定値ダメになったかもしれない　20140405
		AttackDistance = 1		-- 全部1で。
	end
	
	if SleepFlag then
		if InitializedTime + SleepTime < GetTick() then		-- 起動後1秒経ったら
			SleepFlag = false								-- スリープ終わり
		end
		return											-- 起動から1秒間は何もしない
	end
	
	AttackAccelerator(3)				-- APSD補正
	
	local msg	= GetMsg (myid)			-- コマンドを受けたときの処理
	local rmsg	= GetResMsg (myid)		-- Shiftコマンドを受けたときの処理
	
	if (re_msg[1] ~= NONE_CMD) then		-- 予約コマンドがあれば
		TraceAI("<<<<< reserved command >>>>>")
		ProcessCommand(re_msg)
	elseif (msg[1] ~= NONE_CMD) then       -- 手動コマンドがあれば
		ProcessCommand(msg)              -- -> 手動コマンド処理
	elseif (rmsg[1] ~= NONE_CMD) then  -- Shiftコマンドがあれば
		ReservedCommand(rmsg)             -- -> Shiftコマンド処理
	end
	
	ScanActors()						-- 周囲のオブジェクトチェック
	
	StatusCheck(myid)						-- ステータスチェック
	
	if WaitSPR then
		WaitUntilSPR()					-- SPR待ち
	end
	
	if LagCheckFlag then				-- ラグチェック
		CheckLag()
	else
		CheckStack()						-- 移動詰まり解消
	end
	
	MC_AlertCheck()						-- MChアラート
	
	if MyState ~= IDLE_ST or ReturnFlag then			-- 旋回動作用調整
		RondEnd	= os.time()
		if MyState ~= ALERT_ST and MyState ~= ESCAPE_ST and MyState ~= SHOOTING_ST and MyState ~= SEARCH_ST then
			PatrolVector = 0
		end
	end
	
	CheckDistance()						-- 主人との距離チェック
	
	--OutputMap(GlobalMap) 			--mapdebug
	
	if ReturnFlag then			-- 状態処理前に一旦ループを終わらせたい場合
		--TraceAI("  ====------->>> exit")
		return
	end
	
	
	-- 状態処理
	if (MyState == ALERT_ST) then
		OnALERT_ST ()
	end
 	if (MyState == IDLE_ST) then
		OnIDLE_ST ()
	end
	if (MyState == ESCAPE_ST) then
		OnESCAPE_ST ()
	end
	if (MyState == CHASE_ST) then
		OnCHASE_ST ()
	elseif (MyState == HOOK_ST) then
		OnHOOK_ST ()
	end
	if (MyState == ATTACK_ST) then
		OnATTACK_ST ()
	elseif (MyState == SHOOTING_ST) then
		OnSHOOTING_ST ()
	end	
	if (MyState == FOLLOW_ST) then
		OnFOLLOW_ST ()
	elseif (MyState == FORWARD_ST) then
		OnFORWARD_ST ()
	elseif (MyState == MOVE_CMD_ST) then
		OnMOVE_CMD_ST ()
	elseif (MyState == FOLLOW_CMD_ST) then
		OnFOLLOW_CMD_ST ()
	elseif (MyState == SEARCH_ST) then
		OnSEARCH_ST()
	end
	
	AttackAccelerator(2)			-- ASPD補正
	
	--最後に時間を記録：翌周の前回時間となる
	ClockCheck()
end

--時間操作
GetTickL = GetTick
LostTick = 0
function GetTick()
	return GetTickL() + LostTick
end

-- クロックチェック
function ClockCheck()
	if GetPreTick > GetTick() then
		TraceAI("##### Clock Over... ######")
		LostTick = GetPreTick - GetTick()
	end
	GetPreTick = GetTick()
end

-- エラーが出たら空のAI関数に差し替える
function try(func, ...)
	local ok, err = pcall(func, unpack(arg))
	if(not ok) then
		ErrorOut("Error.txt", err)	-- エラー内容をファイルへ
		PrintMessage(99,0,0,0,0,1)
		AI = function() end	-- エラーが出たらAI()関数を空にする
	end
end

-- エラー内容をファイルに出力
function ErrorOut(str1 ,str2)
	local fp = io.open(string.format(SaveDir.."%s", str1), "a")
	if(fp == nil) then return end
	fp:write(string.format("%s : %s\n", os.date("%Y/%m/%d %H:%M:%S"), str2) )
	fp:close()
end

-- メイン
function AI(id)
	try(AImain, id)
end
