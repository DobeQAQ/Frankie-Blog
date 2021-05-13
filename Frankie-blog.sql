/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 13/05/2021 11:40:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首图',
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标记',
  `views` int(11) NULL DEFAULT NULL COMMENT '浏览次数',
  `appreciation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '赞赏',
  `share_statement` tinyint(1) NOT NULL DEFAULT 0 COMMENT '转载声明',
  `commentabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '评论',
  `published` tinyint(1) NOT NULL DEFAULT 0 COMMENT '发布',
  `recommend` tinyint(1) NOT NULL DEFAULT 0 COMMENT '推荐',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `type_id` bigint(20) NULL DEFAULT NULL COMMENT '分类id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '拥有者id',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章描述',
  `tag_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (10, '十四/十五数码难题——BFS', '### Problem\r\n\r\n类似于 3 * 3的8数码难题，4 * 4的十五数码难题。 此题基于4 * 4矩阵， 14数码+2空位//十五数码为15数码+1空位，解法同理\r\n\r\n给定矩阵，要求还原成   1 2 3 4 // 5 6 7 8  // 9 10 11 12 //13 14 0 0\r\n\r\n求最小步数。                           \r\n\r\n### Solution\r\n\r\nBFS暴搜，通过字符串记录状态。为方便交换，将10-14看成A-E。然后就BFS，找到空位，枚举4方向交换字符串对应位置。\r\n### PS\r\n\r\n正解应该A*吧，多几个限制条件，然后改成优先队列。考虑时间还是写的普通BFS，结果未知，可能超时。\r\n\r\n### Code\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\n#define INF 0x3f3f3f3f\r\nusing namespace std;\r\ntypedef long long ll;\r\nstring s;\r\nint a;\r\nint dx[4]= {-1,0,1,0};\r\nint dy[4]= {0,-1,0,1};\r\nstring str;\r\nstring ans=\"123456789ABCDE00\"; //len=16\r\nmap<string,int>mp;\r\nint pos[5],p;\r\nstruct node {\r\n	string s;\r\n	int cnt;\r\n};\r\n/*\r\n10 A\r\n11 B\r\n12 C\r\n13 D\r\n14 E\r\n*/\r\nint solve(string str) {\r\n	mp[str]=1;\r\n	queue<node>q;\r\n	q.push({str,0});\r\n	while(!q.empty()) {\r\n		node t=q.front();\r\n//		cout<<t.s<<\" \"<<t.cnt<<endl;\r\n		q.pop();\r\n		if(t.s==ans) return t.cnt;\r\n		p=0;\r\n		int len=t.s.size();\r\n		for(int i=0; i<len; i++) {\r\n			if(t.s[i]==\'0\') pos[++p]=i;\r\n		}\r\n\r\n		int x=pos[1]/4,y=pos[1]%4;\r\n		for(int i=0; i<4; i++) {\r\n			int xx=x+dx[i],yy=y+dy[i];\r\n			if(xx<0||xx>3||yy<0||yy>3) continue;\r\n			string res=t.s;\r\n			res[pos[1]]=res[xx*4+yy];\r\n			res[xx*4+yy]=\'0\';\r\n			if(mp[res]==1) continue;\r\n			mp[res]=1;\r\n			q.push({res,t.cnt+1});\r\n		}\r\n\r\n		x=pos[2]/4,y=pos[2]%4;\r\n		for(int i=0; i<4; i++) {\r\n			int xx=x+dx[i],yy=y+dy[i];\r\n			if(xx<0||xx>3||yy<0||yy>3) continue;\r\n			string res=t.s;\r\n			res[pos[2]]=res[xx*4+yy];\r\n			res[xx*4+yy]=\'0\';\r\n			if(mp[res]==1) continue;\r\n			mp[res]=1;\r\n			q.push({res,t.cnt+1});\r\n		}\r\n//		system(\"pause\\n\");\r\n	}\r\n\r\n	return -1;\r\n}\r\nint main() {\r\n	for(int i=1; i<=4; i++) {\r\n		for(int j=1; j<=4; j++) {\r\n			cin>>a;\r\n			if(a<=9) str.push_back(a+\'0\');\r\n			else if(a>=10) {\r\n				str.push_back(a-10+\'A\');\r\n			}\r\n		}\r\n	}\r\n	cout<<solve(str);\r\n}\r\n/*\r\n1 0 2 4\r\n5 7 3 8\r\n9 6 10 12\r\n13 14 0 11\r\n\r\n7\r\n*/\r\n```\r\n\r\n', 'https://picsum.photos/id/100/800/450', '原创', 34, 1, 1, 1, 1, 1, '2021-05-11 01:16:22', '2021-05-11 03:41:28', 5, 1, '十四/十五数码难题——BFS', '1,3,2,5,4,7,6');
INSERT INTO `t_blog` VALUES (11, '求t直线交点个数', '### Problem\r\n\r\n 直角坐标系下，直线截距式y=kx+b，以截距式(k,b)给定n条直线，求t直线交点的数量(两直线交点、三直线交点。。。)  t∈[2,n]\r\n\r\n### Solution\r\n\r\nn 1e4， 暴力枚举O(n(n-1)/2)     5e7莽过了，枚举直线交点，判断是否非负，是否整数，对于每个交点的出现次数累加，这里用map记录了。  对于某个交点，组合数C（n,2）为某交点的出现次数，n是对应的直线数量。因此在一开始初始化F[1-1e4]=i*(i-1)/2；二分数组找到下标i，即为经过该交点的直线个数，然后ans[1~n]记录直线个数的出现次数即可\r\n\r\n\r\n### Code\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\n#define INF 0x3f3f3f3f\r\nusing namespace std;\r\ntypedef long long ll;\r\nint n;\r\nstruct node{\r\n	int k,b;\r\n}p[10005];\r\nmap<pair<int,int>,int>cnt;\r\nmap<pair<int,int>,int>::iterator it;\r\nint f[10005];\r\nint ans[100005];\r\nint main() {\r\n	scanf(\"%d\",&n);\r\n	f[1]=0;\r\n	for(int i=2;i<=10000;i++){\r\n		f[i]=i*(i-1)/2;\r\n	}\r\n	for(int i=1;i<=n;i++){\r\n		scanf(\"%d%d\",&p[i].k,&p[i].b);\r\n	}\r\n	for(int i=1;i<n;i++){\r\n		for(int j=i+1;j<=n;j++){\r\n			if(p[i].k==p[j].k) continue;\r\n			else{\r\n				if((p[j].b-p[i].b)%(p[i].k-p[j].k)!=0) continue;\r\n				int xx=(p[j].b-p[i].b)*1.0/(p[i].k-p[j].k);\r\n				int yy=p[i].k*xx+p[i].b;\r\n				if(xx<0||yy<0) continue;\r\n				cnt[make_pair(xx,yy)]++;\r\n			}\r\n		}\r\n	}\r\n	for(it=cnt.begin();it!=cnt.end();it++){\r\n		cout<<it->first.first<<\" \"<<it->first.second<<\":\"<<it->second<<endl;\r\n		int res=(it->second);\r\n		int pos=lower_bound(f+1,f+10000+1,res)-f;\r\n		cout<<pos<<endl;\r\n		ans[pos]++;\r\n	}\r\n	\r\n	for(int i=2;i<=n;i++){\r\n		printf(\"%d \",ans[i]);\r\n	}\r\n\r\n }\r\n```\r\n\r\n', 'https://picsum.photos/id/100/800/450', '转载', 2, 1, 1, 1, 1, 1, '2021-05-11 01:18:03', '2021-05-11 02:59:11', 2, 1, '1212', '1,3,4,2');
INSERT INTO `t_blog` VALUES (12, 'Windows下mysql修改root密码', 'cmd\r\n\r\n```xml\r\nmysqladmin -uroot -p[oldpassowrd] password [newpassword]\r\n//exp:mysqladmin -uroot -p123 password 1234\r\n//原密码为123，新密码为1234\r\n```', 'https://picsum.photos/id/100/800/450', '原创', 2, 1, 1, 1, 1, 1, '2021-05-11 03:02:39', '2021-05-11 03:02:39', 2, 1, '222', '7,1');
INSERT INTO `t_blog` VALUES (13, 'SprintBoot_Thymeleaf   静态资源css,js无法加载', '## Problem\r\n\r\n在调试时可以加载/static/目录下的全部样式，在运行时找不到。\r\n我的目录如下\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210417194411874.png)\r\n\r\n## Solution\r\n（1）application.yml加入\r\n\r\n```xml\r\n  resources:\r\n    add-mappings: true\r\n```\r\n（2）引入css\r\n```xml\r\n<html lang=\"en\"  xmlns:th=\"http://www.thymeleaf.org\">\r\n\r\n<head>\r\n   .......\r\n <link rel=\"stylesheet\" type=\"text/css\" href=\"../static/css/me.css\" th:href=\"@{/css/me.css}\">\r\n```\r\n（3）对于用到的image\r\n\r\n```xml\r\n <img src=\"../static/images/myPhoto.jpeg\" th:src=\"@{/images/myPhoto.jpeg}\" alt=\"\" class=\"ui avatar image\">\r\n```\r\n(4)如果不行的话，重启一下idea再看看', 'https://picsum.photos/id/100/800/450', '原创', 0, 1, 1, 1, 1, 1, '2021-05-11 03:03:18', '2021-05-11 03:03:18', 2, 1, '222', '2,1,3');
INSERT INTO `t_blog` VALUES (14, 'Trie树字典树简单运用——T1259:最短前缀', '## Trie树字典树简单运用——最短前缀\r\n------------------\r\n### 例题：计蒜客T1259：最短前缀\r\n\r\n-----------------------------\r\n\r\n**链接**:[https://vjudge.net/problem/%E8%AE%A1%E8%92%9C%E5%AE%A2-T1259](https://vjudge.net/problem/%E8%AE%A1%E8%92%9C%E5%AE%A2-T1259)\r\n\r\n### 题目\r\n\r\n一个字符串的前缀是从该字符串的第一个字符起始的一个子串。\r\n\r\n例如 \"carbon\" 的字串是: \"c\", \"ca\", \"car\", \"carb\", \"carbo\", 和 \"carbon\"。注意到这里我们不认为空串是子串, 但是每个非空串是它自身的子串. 我们现在希望能用前缀来缩略的表示单词。例如, \"carbohydrate\" 通常用 \"carb\" 来缩略表示. 现在给你一组单词, 要求你找到唯一标识每个单词的最短前缀。\r\n\r\n在下面的例子中，\"carbohydrate\" 能被缩略成\"carboh\", 但是不能被缩略成\"carbo\" (或其余更短的前缀) 因为已经有一个单词用 \"carbo\" 开始。\r\n\r\n一个精确匹配会覆盖一个前缀匹配，例如，前缀 \"car\" 精确匹配单词 \"car\". 因此 \"car\" 是 \"car\" 的缩略语是没有二义性的 , \"car\" 不会被当成 \"carriage\" 或者任何在列表中以 \"car\" 开始的单词。\r\n\r\n#### 输入格式\r\n\r\n输入包括至少 22 行，至多 10001000 行. 每行包括一个以小写字母组成的单词，单词长度至少是 11，至多是 2020。\r\n\r\n#### 输出格式\r\n\r\n输出的行数与输入的行数相同。\r\n\r\n每行输出由相应行输入的单词开始，后面跟着一个空格接下来是相应单词的没有二义性的最短前缀标识符。\r\n\r\n**Sample Input**\r\n\r\n```\r\ncarbohydrate\r\ncart\r\ncarburetor\r\ncaramel\r\ncaribou\r\ncarbonic\r\ncartilage\r\ncarbon\r\ncarriage\r\ncarton\r\ncar\r\ncarbonate\r\n```\r\n\r\n**Sample Output**\r\n\r\n```\r\ncarbohydrate carboh\r\ncart cart\r\ncarburetor carbu\r\ncaramel cara\r\ncaribou cari\r\ncarbonic carboni\r\ncartilage carti\r\ncarbon carbon\r\ncarriage carr\r\ncarton carto\r\ncar car\r\ncarbonate carbona\r\n```\r\n\r\n------------------------------\r\n\r\n### Solution\r\n\r\n​        通过trie字典树，插入每个字符串，在插入过程中用vis[]累加值（意思是：截止某字母，前缀相同的种数）。\r\n\r\n​        查询过程中，依次遍历字符串输出直至vis[]=1为止，即前缀相同的字符串只有1个，符合题意。\r\n\r\n### Code\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\n#define INF 0x3f3f3f3f\r\nusing namespace std;\r\ntypedef long long ll;\r\ninline ll read() {\r\n	ll x=0,f=1;\r\n	char ch=getchar();\r\n	while(ch<\'0\'||ch>\'9\') {\r\n		if(ch==\'-\') f=-1;\r\n		ch=getchar();\r\n	}\r\n	while(ch>=\'0\'&&ch<=\'9\') {\r\n		x=(x<<1)+(x<<3)+ch-\'0\';\r\n		ch=getchar();\r\n	}\r\n	return x*f;\r\n}\r\nconst int maxn=1e5+5;\r\nstring str[1005];\r\nint trie[maxn][30],tot=1,t=0;\r\nint vis[maxn];\r\nvoid insert(string s){\r\n	int len=s.size(),root=1;\r\n	for(int k=0;k<len;k++){\r\n		int ch=s[k]-\'a\';\r\n		if(trie[root][ch]==0) trie[root][ch]=++tot;\r\n		vis[trie[root][ch]]++;\r\n		root=trie[root][ch];\r\n	}\r\n}\r\nvoid search(string s){\r\n    int len=s.size(),root=1;\r\n    for(int i=0;i<len;i++){\r\n    	cout<<s[i];\r\n    	int ch=s[i]-\'a\';\r\n    	if(vis[trie[root][ch]]==1) break;\r\n    	root=trie[root][ch];\r\n	}\r\n}\r\nint main(){\r\n	while(cin>>str[++t]){\r\n		insert(str[t]);\r\n	}\r\n	for(int i=1;i<=t;i++){\r\n		cout<<str[i]<<\" \";\r\n	    search(str[i]);\r\n	    cout<<endl;\r\n	}\r\n}\r\n```\r\n\r\n', 'https://picsum.photos/id/100/800/450', '原创', 1, 1, 1, 1, 1, 1, '2021-05-11 03:03:49', '2021-05-11 03:03:49', 8, 1, '12332', '2,1,4,3');
INSERT INTO `t_blog` VALUES (15, '线段树区间和（区间修改/区间查询/单点修改/单点查询）', '线段树区间和\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nconst int maxn=100005;\r\nint n,m,p,ans,x,l,r,val;\r\nstruct node {\r\n	int l,r,w,f;//f为延迟标记\r\n} tree[4*maxn+5];\r\nvoid build(int k,int l,int r) { //建树\r\n	tree[k].l=l,tree[k].r=r;\r\n	if(tree[k].l==tree[k].r) {\r\n		scanf(\"%d\",&tree[k].w);\r\n		return;\r\n	}\r\n	int mid=(l+r)/2;\r\n	build(k*2,l,mid);//左孩子\r\n	build(k*2+1,mid+1,r);//右孩子\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\nvoid spread(int k) {//延迟标记\r\n	tree[k*2].f+=tree[k].f;\r\n	tree[k*2+1].f+=tree[k].f;\r\n	tree[k*2].w+=tree[k].f*(tree[k*2].r-tree[k*2].l+1);\r\n	tree[k*2+1].w+=tree[k].f*(tree[k*2+1].r-tree[k*2+1].l+1);\r\n	tree[k].f=0;\r\n}\r\nvoid ask(int k,int x) {//单点查询 ，x为查询位置\r\n	if(tree[k].l==tree[k].r) {\r\n		ans=tree[k].w;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) ask(2*k,x);\r\n	else ask(2*k+1,x);\r\n}\r\nvoid change(int k,int x,int val) {//单点修改 x修改位置，val增加的值\r\n	if(tree[k].l==tree[k].r) {\r\n		tree[k].w+=val;//\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) change(2*k,x,val);\r\n	else change(2*k+1,x,val);\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\nvoid query(int k,int x,int y) { //区间查询[x,y] 的和\r\n	if(tree[k].l>=x&&tree[k].r<=y) {\r\n		ans+=tree[k].w;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) query(2*k,x,y);\r\n	if(y>mid) query(2*k+1,x,y);\r\n}\r\n\r\nvoid modify(int k,int x,int y,int val) { //区间修改\r\n	if(tree[k].l>=x&&tree[k].r<=y) {\r\n		tree[k].w+=(tree[k].r-tree[k].l+1)*val;\r\n		tree[k].f+=val;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) modify(2*k,x,y,val);\r\n	if(y>mid) modify(2*k+1,x,y,val);\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\n\r\nint main() {\r\n	scanf(\"%d%d\",&n,&m);//n个节点,m个操作;\r\n	build(1,1,n);\r\n	while(m--) {\r\n		scanf(\"%d\",&p);\r\n		ans=0;\r\n		if(p==1){//查询节点x的值 ，单点查询 \r\n			scanf(\"%d\",&x);\r\n			ask(1,x);\r\n			printf(\"%d\\n\",ans);\r\n		}else if(p==2){//节点x增加val，单点修改 \r\n			scanf(\"%d%d\",&x,&val);\r\n			change(1,x,val);\r\n		}else if(p==3){//区间查询 \r\n			scanf(\"%d%d\",&l,&r);\r\n			query(1,l,r);\r\n			printf(\"%d\\n\",ans);\r\n		}else if(p==4){//区间[l,r]都增加val,区间修改 \r\n			scanf(\"%d%d%d\",&l,&r,&val);\r\n			modify(1,l,r,val);\r\n		}\r\n	}\r\n}\r\n/*\r\n9 8\r\n1 2 3 4 5 6 7 8 9\r\n1 5\r\n3 4 8\r\n2 5 100\r\n1 5 \r\n3 4 9\r\n4 2 6 77\r\n1 6\r\n3 1 9\r\n\r\nans:\r\n5\r\n30\r\n105\r\n139\r\n83\r\n530\r\n*/ \r\n\r\n\r\n\r\n\r\n\r\n```\r\n', 'https://picsum.photos/id/100/800/450', '原创', 1, 1, 1, 1, 1, 1, '2021-05-11 03:04:26', '2021-05-11 03:11:19', 5, 1, '12312321', '4');
INSERT INTO `t_blog` VALUES (16, 'kmp next数组求法——子串前缀，后缀，中间出现3次', '（题目忘记是哪道了）\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nstring s;\r\nint len,nxt[1000005],cnt[1000005];\r\nvoid get_next(string s) {\r\n	int i=0,j=-1;\r\n	nxt[0]=-1;\r\n	int len=s.size();\r\n	while(i<len) {\r\n		if(j==-1||s[i]==s[j]) nxt[++i]=++j;\r\n		else j=nxt[j];\r\n	}\r\n}\r\nint main() {\r\n	cin>>s;\r\n	int len=s.size();\r\n	get_next(s);\r\n	for(int i=1; i<len; i++) cnt[nxt[i]]++;\r\n	cout<<\"   \";\r\n	for(int i=0;i<len;i++) cout<<s[i]<<\" \";\r\n	cout<<endl;\r\n	for(int i=0;i<=len;i++) cout<<nxt[i]<<\" \";\r\n	\r\n	if(nxt[len]<=0) return cout<<\"Just a legend\",0;\r\n	if(cnt[nxt[len]])   return cout<<s.substr(0,nxt[len]),0;\r\n	if(nxt[nxt[len]]>0) return cout<<s.substr(0,nxt[nxt[len]]),0;\r\n	return cout<<\"Just a legend\",0;\r\n}\r\n```\r\n', 'https://picsum.photos/id/100/800/450', '原创', 0, 1, 1, 1, 1, 1, '2021-05-11 03:10:57', '2021-05-11 03:10:57', 5, 1, '12312', '1,2,3,4');
INSERT INTO `t_blog` VALUES (17, '线段树区间和（区间修改/区间查询/单点修改/单点查询）', '线段树区间和\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nconst int maxn=100005;\r\nint n,m,p,ans,x,l,r,val;\r\nstruct node {\r\n	int l,r,w,f;//f为延迟标记\r\n} tree[4*maxn+5];\r\nvoid build(int k,int l,int r) { //建树\r\n	tree[k].l=l,tree[k].r=r;\r\n	if(tree[k].l==tree[k].r) {\r\n		scanf(\"%d\",&tree[k].w);\r\n		return;\r\n	}\r\n	int mid=(l+r)/2;\r\n	build(k*2,l,mid);//左孩子\r\n	build(k*2+1,mid+1,r);//右孩子\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\nvoid spread(int k) {//延迟标记\r\n	tree[k*2].f+=tree[k].f;\r\n	tree[k*2+1].f+=tree[k].f;\r\n	tree[k*2].w+=tree[k].f*(tree[k*2].r-tree[k*2].l+1);\r\n	tree[k*2+1].w+=tree[k].f*(tree[k*2+1].r-tree[k*2+1].l+1);\r\n	tree[k].f=0;\r\n}\r\nvoid ask(int k,int x) {//单点查询 ，x为查询位置\r\n	if(tree[k].l==tree[k].r) {\r\n		ans=tree[k].w;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) ask(2*k,x);\r\n	else ask(2*k+1,x);\r\n}\r\nvoid change(int k,int x,int val) {//单点修改 x修改位置，val增加的值\r\n	if(tree[k].l==tree[k].r) {\r\n		tree[k].w+=val;//\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) change(2*k,x,val);\r\n	else change(2*k+1,x,val);\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\nvoid query(int k,int x,int y) { //区间查询[x,y] 的和\r\n	if(tree[k].l>=x&&tree[k].r<=y) {\r\n		ans+=tree[k].w;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) query(2*k,x,y);\r\n	if(y>mid) query(2*k+1,x,y);\r\n}\r\n\r\nvoid modify(int k,int x,int y,int val) { //区间修改\r\n	if(tree[k].l>=x&&tree[k].r<=y) {\r\n		tree[k].w+=(tree[k].r-tree[k].l+1)*val;\r\n		tree[k].f+=val;\r\n		return;\r\n	}\r\n	if(tree[k].f) spread(k);\r\n	int mid=(tree[k].l+tree[k].r)/2;\r\n	if(x<=mid) modify(2*k,x,y,val);\r\n	if(y>mid) modify(2*k+1,x,y,val);\r\n	tree[k].w=tree[k*2].w+tree[k*2+1].w;\r\n}\r\n\r\nint main() {\r\n	scanf(\"%d%d\",&n,&m);//n个节点,m个操作;\r\n	build(1,1,n);\r\n	while(m--) {\r\n		scanf(\"%d\",&p);\r\n		ans=0;\r\n		if(p==1){//查询节点x的值 ，单点查询 \r\n			scanf(\"%d\",&x);\r\n			ask(1,x);\r\n			printf(\"%d\\n\",ans);\r\n		}else if(p==2){//节点x增加val，单点修改 \r\n			scanf(\"%d%d\",&x,&val);\r\n			change(1,x,val);\r\n		}else if(p==3){//区间查询 \r\n			scanf(\"%d%d\",&l,&r);\r\n			query(1,l,r);\r\n			printf(\"%d\\n\",ans);\r\n		}else if(p==4){//区间[l,r]都增加val,区间修改 \r\n			scanf(\"%d%d%d\",&l,&r,&val);\r\n			modify(1,l,r,val);\r\n		}\r\n	}\r\n}\r\n/*\r\n9 8\r\n1 2 3 4 5 6 7 8 9\r\n1 5\r\n3 4 8\r\n2 5 100\r\n1 5 \r\n3 4 9\r\n4 2 6 77\r\n1 6\r\n3 1 9\r\n\r\nans:\r\n5\r\n30\r\n105\r\n139\r\n83\r\n530\r\n*/ \r\n\r\n\r\n\r\n\r\n\r\n```\r\n', 'https://picsum.photos/id/100/800/450', '原创', 0, 1, 1, 1, 1, 1, '2021-05-11 03:11:40', '2021-05-11 03:11:40', 5, 1, '123', '1,3,4,5,6');
INSERT INTO `t_blog` VALUES (18, 'xampp中mysql3306端口被占用', '# xampp，mysql3306端口被占用\r\n**Problem**：mysql3306端口被占用，根据网上方法，停止服务、更换端口等方法都无法解决。解决方法如下：\r\n\r\n下图是已解决的\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192619579.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ZyYW5raWVfS3U=,size_16,color_FFFFFF,t_70)\r\n\r\n--------------------------\r\n### Solution\r\n\r\n**Step1：win+R，输入regedit，打开注册表编辑器**: \r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192505426.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ZyYW5raWVfS3U=,size_16,color_FFFFFF,t_70)\r\n\r\n\r\n**Step2：根据路径找到mysql目录**\r\n\r\n```\r\n计算机\\HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\MySQL\r\n```\r\n\r\n\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192524150.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ZyYW5raWVfS3U=,size_16,color_FFFFFF,t_70)\r\n\r\n**Step3：修改ImagePath，..\\bin\\后面的保留，为xmapp中的mysqld MySQL路径**\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192538913.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ZyYW5raWVfS3U=,size_16,color_FFFFFF,t_70)\r\n**具体路径可点击mysql旁边的config中的mysql.ini文件查看**\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192747485.png)\r\n![在这里插入图片描述](https://img-blog.csdnimg.cn/20210407192816220.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0ZyYW5raWVfS3U=,size_16,color_FFFFFF,t_70)\r\n\r\n## 注意：\r\n原imagePath路径记得保存\r\n', 'https://picsum.photos/id/100/800/450', '原创', 0, 1, 1, 1, 1, 1, '2021-05-11 03:12:37', '2021-05-11 03:12:37', 1, 1, 'xampp中mysql3306端口被占用', '1,2,3');
INSERT INTO `t_blog` VALUES (19, 'HDU-1175  连连看', '# HDU-1175  连连看\r\n\r\n**Problem**:   n * m 矩阵中，连连看，两个相同的格子消除需要：（1）连线至多两折 （2）连线上都为0 （3）不能出边界\r\n\r\n**Solution**: DFS\r\n\r\n**Code**:\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\n#define INF 0x3f3f3f3f\r\nusing namespace std;\r\ntypedef long long ll;\r\ninline ll read() {\r\n	ll x=0,f=1;\r\n	char ch=getchar();\r\n	while(ch<\'0\'||ch>\'9\') {\r\n		if(ch==\'-\') f=-1;\r\n		ch=getchar();\r\n	}\r\n	while(ch>=\'0\'&&ch<=\'9\') {\r\n		x=(x<<1)+(x<<3)+ch-\'0\';\r\n		ch=getchar();\r\n	}\r\n	return x*f;\r\n}\r\nint n,m,xa,xb,ya,yb,q;\r\nint a[1005][1005];\r\nint vis[1005][1005];\r\nint dx[4]={-1,0,1,0};\r\nint dy[4]={0,-1,0,1};\r\nbool flag;\r\nvoid solve(int x,int y,int turn,int dir){\r\n    //两折后，必须与终点要在同一直线\r\n	if(flag||turn>2||(turn==2&&x!=xb&&y!=yb)) return;\r\n//	cout<<x<<\" \"<<y<<\" \"<<turn<<\" \"<<dir<<endl;\r\n	if(x==xb&&y==yb&&turn<=2){\r\n		flag=true;\r\n		return;\r\n	}\r\n\r\n	for(int i=0;i<4;i++){\r\n		int xx=x+dx[i],yy=y+dy[i];\r\n		if(xx<1||xx>n||yy<1||yy>m||vis[xx][yy]) continue;\r\n		if(a[xx][yy]==0||(xx==xb&&yy==yb)){\r\n			vis[xx][yy]=1;\r\n            //dir=-1，表示初始点选择方向不需要1折\r\n			if(dir==-1||dir==i) solve(xx,yy,turn,i);\r\n			else solve(xx,yy,turn+1,i);\r\n			vis[xx][yy]=0;\r\n		}\r\n	}\r\n}\r\nint main() {\r\n	while(cin>>n>>m) {\r\n		if(n==0&&m==0) break;\r\n		for(int i=1;i<=n;i++){\r\n			for(int j=1;j<=m;j++){\r\n				a[i][j]=read();\r\n			}\r\n		}\r\n		q=read();\r\n		while(q--){\r\n			xa=read(),ya=read();\r\n			xb=read(),yb=read();\r\n			if(xa==xb&&ya==yb){\r\n				printf(\"NO\\n\");\r\n				continue;\r\n			}\r\n			if(!a[xa][ya]||!a[xb][yb]||a[xa][ya]!=a[xb][yb]){\r\n				printf(\"NO\\n\");\r\n				continue;\r\n			}\r\n			memset(vis,0,sizeof(vis));\r\n			flag=false;\r\n			solve(xa,ya,0,-1);\r\n			if(!flag) printf(\"NO\\n\");\r\n			else printf(\"YES\\n\");\r\n		}\r\n	}\r\n	return 0;\r\n}\r\n```\r\n\r\n', '', '原创', 2, 1, 1, 1, 1, 1, '2021-05-11 03:13:08', '2021-05-12 22:57:29', 16, 1, 'HDU-1175  连连看', '2,3,4');
INSERT INTO `t_blog` VALUES (20, 'HDU-2782  The Worm Turns', '# HDU-2782  The Worm Turns \r\n\r\n**Problem**:   m * n 矩阵中，按某方向一直走直到墙壁或者已走过才会转向，输出最远的路，起点坐标和初始方向，距离相同下起点（x,y）字典序最小，起点也相同时，方向字典序最小，即\"ENSW\"\r\n\r\n**Solution**: DFS，注意初始方向的设置即可\r\n\r\n**Code**:\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\n#define INF 0x3f3f3f3f\r\nusing namespace std;\r\ntypedef long long ll;\r\ninline ll read() {\r\n	ll x=0,f=1;\r\n	char ch=getchar();\r\n	while(ch<\'0\'||ch>\'9\') {\r\n		if(ch==\'-\') f=-1;\r\n		ch=getchar();\r\n	}\r\n	while(ch>=\'0\'&&ch<=\'9\') {\r\n		x=(x<<1)+(x<<3)+ch-\'0\';\r\n		ch=getchar();\r\n	}\r\n	return x*f;\r\n}\r\nint t,n,m,r,x,y,ans,stx,sty,cnt,ansx,ansy,ansdir,res;\r\nint dx[4]= {0,-1,1,0};\r\nint dy[4]= {1,0,0,-1};\r\nint vis[1005][1005];\r\nvoid solve(int x,int y,int dir,int sum) {\r\n	if(sum>res) {\r\n		res=sum;\r\n	}\r\n	int xx=x+dx[dir],yy=y+dy[dir];\r\n	if(xx>=0&&xx<m&&yy>=0&&yy<n&&!vis[xx][yy]) {\r\n		vis[xx][yy]=1;\r\n		solve(xx,yy,dir,sum+1);\r\n		vis[xx][yy]=0;\r\n	} else {\r\n		for(int i=0; i<4; i++) {\r\n			int xx=x+dx[i],yy=y+dy[i];\r\n			if(xx>=0&&xx<m&&yy>=0&&yy<n&&!vis[xx][yy]) {\r\n				vis[xx][yy]=1;\r\n				solve(xx,yy,i,sum+1);\r\n				vis[xx][yy]=0;\r\n			}\r\n		}\r\n	}\r\n}\r\nint main() {\r\n	while(cin>>m>>n) {\r\n		if(m==0&&n==0) break;\r\n		r=read();\r\n		memset(vis,0,sizeof(vis));\r\n		for(int i=1; i<=r; i++) {\r\n			x=read(),y=read();\r\n			vis[x][y]=1;\r\n		}\r\n		ans=0;\r\n		for(int i=0; i<m; i++) {\r\n			for(int j=0; j<n; j++) {\r\n				if(!vis[i][j]) {\r\n					vis[i][j]=1;\r\n					for(int k=0; k<4; k++) {\r\n						int xx=i+dx[k],yy=j+dy[k];\r\n						if(xx<0||xx>=m||yy<0||yy>=n||vis[xx][yy]) continue;\r\n						res=0;\r\n						solve(i,j,k,1);\r\n						if(res>ans) {\r\n							ans=res;\r\n							ansx=i,ansy=j,ansdir=k;\r\n						}\r\n					}\r\n					vis[i][j]=0;\r\n				}\r\n			}\r\n		}\r\n		printf(\"Case %d: \",++t);\r\n		printf(\"%d %d %d \",ans,ansx,ansy);\r\n		if(ansdir==0) printf(\"E\\n\");\r\n		else if(ansdir==1) printf(\"N\\n\");\r\n		else if(ansdir==2) printf(\"S\\n\");\r\n		else if(ansdir==3) printf(\"W\\n\");\r\n	}\r\n	return 0;\r\n}\r\n\r\n```\r\n\r\n', 'https://picsum.photos/id/100/800/450', '原创', 0, 1, 1, 1, 1, 1, '2021-05-11 03:13:32', '2021-05-11 03:13:32', 5, 1, 'HDU-2782  The Worm Turns', '2,3,4');
INSERT INTO `t_blog` VALUES (21, 'Gym101521GHIJKL-----La Salle-Pui Ching Programming Challenge 培正喇沙編程挑戰賽 2016', '# La Salle-Pui Ching Programming Challenge 培正喇沙編程挑戰賽 2016\r\n\r\n@[toc]\r\n[题目链接：http://codeforces.com/gym/101521](http://codeforces.com/gym/101521)\r\n### **G . Monorail**  \r\n\r\n**题意**：给定直道数n、弯道数m，判断是否能组成一个闭合环路，\r\n\r\n有则输出由\".\"   \"|\"    \"-\"  \"  r\"   \"J\"    \"7\"    \"L\"   表示对应的图形\r\n\r\n**题解**：（1）M、N必须是偶数    \r\n\r\n​              (2)   N=0时，M必须整除4,  M不能等于8\r\n\r\n​              (3)   M除4余2时，疑似有 (N,M):   (2,6)  (4,10)  ......的规律\r\n\r\n分类解决，m整除4时有类似如下两种情况：直道加在第一行和最后两行\r\n\r\n分别以菱形式扩展和在菱形基础上往右下角扩展\r\n\r\nm为8时，三行凸字形，有直道加在第一行和第三行中间\r\n\r\n当m为除4余2时，尚待解决\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nint n,m;\r\nint main() {\r\n	scanf(\"%d%d\",&n,&m);\r\n	if(m%2||n%2) return cout<<\"impossible\",0;\r\n	if(n==0&&(m%4||m==8))  return cout<<\"impossible\",0;\r\n	if(m==8) {\r\n		cout<<3<<\" \"<<4+(n-2)/2<<endl; \r\n		printf(\".r\");\r\n		for(int i=1; i<=(n-2)/2; i++) printf(\"-\");\r\n		printf(\"7.\");\r\n		printf(\"\\n\");\r\n		printf(\"rJ\");\r\n		for(int i=1; i<=(n-2)/2; i++) printf(\".\");\r\n		printf(\"L7\");\r\n		printf(\"\\n\");\r\n		printf(\"L-\");\r\n		for(int i=1; i<=(n-2)/2; i++) printf(\"-\");\r\n		printf(\"-J\");\r\n		return 0;\r\n	}\r\n	if(m%4==0) {\r\n		cout<<m/4+1<<\" \"<<m/4+1+n/2<<endl;\r\n		int lp=floor((m/4-1)/2);\r\n		int rp=floor(m/8);\r\n		for(int i=1; i<=lp; i++) printf(\".\");\r\n		printf(\"r\");\r\n		for(int i=1; i<=n/2; i++) printf(\"-\");\r\n		printf(\"7\");\r\n		for(int i=1; i<=rp; i++) printf(\".\");\r\n		printf(\"\\n\");\r\n		for(int i=1; i<=floor((m/4-1)/2); i++) {\r\n			lp--;\r\n			rp--;\r\n			for(int i=1; i<=lp; i++) {\r\n				printf(\".\");\r\n			}\r\n			printf(\"rJ\");\r\n			for(int i=1; i<floor((m/4-1)/2)-lp; i++) printf(\".\");\r\n			for(int i=1; i<=n/2; i++) printf(\".\");\r\n			for(int i=1; i<floor(m/8)-rp; i++) printf(\".\");\r\n			printf(\"L7\");\r\n			for(int i=1; i<=rp; i++) {\r\n				printf(\".\");\r\n			}\r\n			printf(\"\\n\");\r\n		}\r\n		if((m/4)%2==1) {\r\n			for(int i=1; i<=floor((m/4-1)/2); i++) {\r\n				for(int i=1; i<=lp; i++) printf(\".\");\r\n				printf(\"L7\");\r\n				for(int i=1; i<floor((m/4-1)/2)-lp; i++) printf(\".\");\r\n				for(int i=1; i<=n/2; i++) printf(\".\");\r\n				for(int i=1; i<floor(m/8)-rp; i++) printf(\".\");\r\n				printf(\"rJ\");\r\n				for(int i=1; i<=rp; i++) 	printf(\".\");\r\n				printf(\"\\n\");\r\n				lp++;\r\n				rp++;\r\n			}\r\n			for(int i=1; i<=lp; i++) printf(\".\");\r\n			printf(\"L\");\r\n			for(int i=1; i<=n/2; i++) printf(\"-\");\r\n			printf(\"J\");\r\n			for(int i=1; i<=rp; i++) printf(\".\");\r\n		} else {\r\n			rp--;\r\n			printf(\"L7\");\r\n			for(int i=1; i<floor((m/4-1)/2)-lp; i++) printf(\".\");\r\n			for(int i=1; i<=n/2; i++) printf(\".\");\r\n			for(int i=1; i<floor(m/8)-rp; i++) printf(\".\");\r\n			printf(\"L7\");\r\n			printf(\"\\n\");\r\n			lp++;\r\n			for(int i=1; i<floor((m/4-1)/2); i++) {\r\n				for(int i=1; i<=lp; i++) printf(\".\");\r\n				printf(\"L7\");\r\n				for(int i=1; i<floor((m/4-1)/2)-lp; i++) printf(\".\");\r\n				for(int i=1; i<=n/2; i++) printf(\".\");\r\n				for(int i=1; i<floor(m/8)-rp; i++) printf(\".\");\r\n				printf(\"rJ\");\r\n				for(int i=1; i<=rp; i++) printf(\".\");\r\n				printf(\"\\n\");\r\n				lp++;\r\n				rp++;\r\n			}\r\n			for(int i=1; i<=lp; i++) printf(\".\");\r\n			printf(\"L\");\r\n			for(int i=1; i<=n/2; i++) printf(\"-\");\r\n			printf(\"7\");\r\n			for(int i=1; i<floor((m/4-1)/2)-lp; i++) printf(\".\");\r\n			for(int i=1; i<floor(m/8)-rp-1; i++) printf(\".\");\r\n			printf(\"rJ\");\r\n			for(int i=1; i<=rp; i++) printf(\".\");\r\n			printf(\"\\n\");\r\n			lp++;\r\n			rp++;\r\n			for(int i=1; i<=lp; i++) printf(\".\");\r\n			for(int i=1; i<=n/2; i++) printf(\".\");\r\n			printf(\"LJ\");\r\n			for(int i=1; i<=rp; i++) printf(\".\");\r\n		}\r\n		return 0;\r\n	}\r\n    cout<<\"impossible\";\r\n    return 0;\r\n}\r\n```\r\n\r\n### H. Pokemon GO \r\n\r\n**题意**：一幅无向带权图，给出点的个数和边以及边的长度，问是否存在一条路径使得从点A到点B路程恰好为K(可重复)，如果有打印路径，没有则打印Impossible。\r\n\r\n**题解**：使用邻接表创建无向带权图G，dfs(图(G)，目前位置(i)，目前总路程(len))查找路径。最开始为dfs(G,A,0),目标是dfs(G,B,K)。\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nint N,M,K,A,B,way[5000],cnt=0;\r\n#define  MAX_VERTEX_NUM 1005//最大顶点个数\r\ntypedef struct ArcNode{\r\n    int adjvex;//邻接点在数组中的位置下标\r\n    struct ArcNode * nextarc;//指向下一个邻接点的指针\r\n    int length;\r\n}ArcNode;\r\ntypedef struct VNode{\r\n    int data;//顶点的数据域\r\n    ArcNode * firstarc;//指向邻接点的指针\r\n}VNode,AdjList[MAX_VERTEX_NUM];//存储各链表头结点的数组\r\ntypedef struct {\r\n    AdjList vertices;//图中顶点的数组\r\n    int vexnum,arcnum;//记录图中顶点数和边或弧数\r\n}ALGraph;\r\nvoid creat(ALGraph &G){\r\n	int i,j,k,length;\r\n	ArcNode *p;\r\n	G.vexnum=N;\r\n	G.arcnum=M;\r\n	for(i=0;i<G.vexnum;i++){//头插法\r\n		G.vertices[i].data=i+1;\r\n		G.vertices[i].firstarc=NULL;\r\n	}\r\n	for(k=0;k<G.arcnum;k++){\r\n		cin>>i>>j>>length;\r\n		p=new ArcNode;\r\n		p->length=length;\r\n		p->adjvex=j;\r\n		p->nextarc=G.vertices[i].firstarc;\r\n		G.vertices[i].firstarc=p; \r\n	}\r\n}\r\n\r\nvoid dfs(ALGraph G,int i,int len){//方法没能实现。。。\r\n	ArcNode *p;\r\n	int k;\r\n	p=NULL;\r\n	cout<<\"case:  \"<<i<<\"   \"<<len<<endl;\r\n	if(i==B&&len==K){\r\n		cout<<\"YES\"; \r\n	}\r\n	else{\r\n		for(p=G.vertices[i].firstarc;p;p=p->nextarc){\r\n			if(p->length+len<=K){\r\n				int len1=len;\r\n				len1+=p->length;\r\n				k=p->adjvex;\r\n//				cout<<k<<endl;\r\n				dfs(G,k,len1); \r\n			}else continue;\r\n		}\r\n	}\r\n} \r\n//问题1：无向图没有体现无向性，没能重复走。\r\n//问题2：即使确定了有该路径，但是没能保存路径的顺序。\r\nint main(){\r\n	ALGraph G;\r\n	cin>>N>>M>>K;\r\n	cin>>A>>B;\r\n	creat(G);\r\n	dfs(G,A,0);\r\n    return 0;\r\n} \r\n```\r\n\r\n\r\n\r\n###  I. RNG\r\n\r\n**题意**：给定一串15位序列{**Xn**}(部分缺失且X1必缺)，求该序列符合下述递推规则的a,b,c,d,m,X1,其中    Xi∈{1,2,3,4},没有符合的输出6个-1\r\n$$\r\nX_(i+1)=(aX_i^3+bX_i^2+cX_i+d)mod(m)\r\n$$\r\n**题解**：如果已知给定序列存在满足的解，则m=5时必有解，枚举0<=a,b,c,d<=4,   m=5, 1<=x<=4，\r\n\r\n共5 * 5 * 5 * 5 * 4=2500种, 满足递推规则输出\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nint a,b,c,d,m=5,x1,f[15];\r\nbool flag;\r\nstring s;\r\nint main() {\r\n	cin>>s;\r\n	for(int x1=1; x1<=4; x1++) {\r\n		f[0]=x1;\r\n		for(int a=0; a<=4; a++) {\r\n			for(int b=0; b<=4; b++) {\r\n				for(int c=0; c<=4; c++) {\r\n					for(int d=0; d<=4; d++) {\r\n						flag=false;\r\n						for(int i=1; i<=14; i++) {\r\n							f[i]=(a*f[i-1]*f[i-1]*f[i-1]+b*f[i-1]*f[i-1]+c*f[i-1]+d)%m;\r\n							if(s[i]!=\'?\') {\r\n								if(f[i]!=s[i]-\'0\') {\r\n									flag=false;\r\n									break;\r\n								} else {\r\n									flag=true;\r\n								}\r\n							}\r\n						}\r\n						if(flag) {\r\n//							for(int i=0;i<=14;i++){\r\n//								cout<<f[i];\r\n//							}\r\n//							cout<<endl;\r\n							return cout<<a<<\" \"<<b<<\" \"<<c<<\" \"<<d<<\" \"<<m<<\" \"<<x1<<endl,0;\r\n						}\r\n					}\r\n				}\r\n			}\r\n		}\r\n	}\r\n	printf(\"-1 -1 -1 -1 -1 -1\");\r\n}\r\n```\r\n\r\n\r\n\r\n### **J. Posters**\r\n\r\n**题意**：两人在公告栏（h ,w）上贴海报（ha ,wa）,(hb ,wb）； 第一个人先贴（ha ,wa）\r\n\r\nPlan A: 让第二个人也能贴上去；能满足Yes，不能满足No ; \r\n\r\nPlan B: 让第二个人贴不上去：能满足Yes，不能满足No;\r\n\r\n第一个人如果贴不上去输出No:（ha>h || wa>h）\r\n\r\n**题解**：\r\n\r\n1、对于Plan A：两种情况满足任意一种就Yes\r\n\r\n2、对于Plan B: 放中间。两种情况下，第二张可以贴上去\r\n\r\n当以上两种情况都不满足Yes，否则No;\r\n\r\n注意：当第一张海报尺寸超出公告栏尺寸时也为No;(即ha>h || wa>w)\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nint h,w,ha,hb,wa,wb;\r\nint main() {\r\n	cin>>h>>w>>ha>>wa>>hb>>wb;\r\n	if((ha<=h&&hb<=h&&(wa+wb)<=w)||(wa<=w&&wb<=w&&(ha+hb)<=h)) {\r\n		cout<<\"Yes\"<<endl;\r\n	} else {\r\n		cout<<\"No\"<<endl;\r\n	}\r\n	if(ha>h||wa>w) {\r\n		cout<<\"No\"<<endl;\r\n	} else {\r\n		bool flag=false;\r\n		if(hb<=(h-ha)/2.0&&wb<=w) {\r\n			flag=true;\r\n		}\r\n		if(wb<=(w-wa)/2.0&&hb<=h) {\r\n			flag=true;\r\n		}\r\n		if(flag) {\r\n			cout<<\"No\"<<endl;\r\n		} else {\r\n			cout<<\"Yes\"<<endl;\r\n		}\r\n	}\r\n	return 0;\r\n}\r\n```\r\n\r\n### **K. Lattice Points**\r\n\r\n**题意**：求与以R为半径的圆（0,0），所有距离小于D的整数坐标点个数，令该点(x,y)\r\n\r\n**题解**：\r\n\r\n由题意得： \r\n$$\r\n|√(x^2+y^2 )-R|≤D\r\n$$\r\n即：   \r\n$$\r\n  R-D≤√(x^2+y^2 )≤R+D  \r\n$$\r\n（1）当R<=D时,求以R+D为半径的大圆内（含边界）的整数坐标点的个数\r\n\r\n​                   令第一象限符合要求的个数为cnt1;\r\n\r\n​                   求cnt1:   y从1到R+D，每行点个数累加求和\r\n\r\n​                   每行的点的个数为：\r\n$$\r\n⌊√((R+D)^2-y^2 )⌋+1\r\n$$\r\n​                                                          勾股定理向下取整+y轴上的点\r\n\r\n​                   由圆的对称性，总的个数为: 4*cnt1+1;(原点)\r\n\r\n（2）当R>D时, 求以R+D为半径的圆与以R-D为半径的圆中间的圆环有多少个整数点（两条边界包括）\r\n\r\n​      即：       求大圆内的点（包含边界）—  小圆内的点（不包含边界）\r\n\r\n​                     大圆内的点（含边界）参考（1） ：总数为4*cnt1+1;\r\n\r\n​                     小圆内的点（不含边界）：令第一象限符合要求的个数为cnt2;\r\n\r\n​                      求cnt2:   y从1到R-D，每行点个数累加求和\r\n\r\n​                      每行点个数为：\r\n$$\r\n⌈√((R-D)^2-y^2 )⌉\r\n$$\r\n​                                                                  勾股定理向上取整\r\n\r\n​                  由圆对称性  总数4*cnt2+1;\r\n\r\n即：Answer=4*(cnt1-cnt2);\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\ntypedef  unsigned long long ll;\r\nll r,d，cnt1=0,cnt2=0,cnt3=0;\r\nint main(){\r\n	cin>>r>>d;\r\n	for(ll i=1;i<=r+d;i++){//求大圆内（含边界）的整数坐标点个数\r\n		cnt1+=floor(sqrt((r+d)*(r+d)-i*i))+1;		\r\n	}	\r\n	if(r<=d) return cout<<4*cnt1+1,0;\r\n	for(ll i=1;i<=r-d;i++){//求小圆内（不含边界）的整数坐标点个数\r\n		cnt2+=ceil(sqrt((r-d)*(r-d)-i*i));\r\n	}\r\n	cout<<4*(cnt1-cnt2);\r\n	return 0; \r\n}\r\n\r\n```\r\n\r\n### **L. Textbook Game**\r\n\r\n**题意：**\r\n\r\n​       给出页数和每页的人脸数，两人PK翻一页,人脸数多获胜;求当第一个人翻第i页时，其胜、平、负的几率各为多少。\r\n\r\n**题解**：计算几页比他翻的多和少即可。\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\nconst int maxn=100005;\r\nint n,big,small,eq;\r\nint f[maxn];\r\nvector<int>up;\r\nint main(){\r\n	scanf(\"%d\",&n);\r\n	for(int i=1;i<=n;i++){\r\n		scanf(\"%d\",&f[i]);\r\n		up.push_back(f[i]);\r\n	}\r\n	sort(up.begin(),up.end());\r\n	for(int i=1;i<=n;i++){\r\n	 big=0;\r\n	 small=0;\r\n	 eq=0;\r\n	 int t1,t2;\r\n	 t1=lower_bound(up.begin(),up.end(),f[i])-up.begin();  //找有几页更少\r\n	 small=t1;\r\n	 if(up[n-1]==f[i])   big=0;\r\n	 else {\r\n			t2=upper_bound(up.begin(),up.end(),f[i])-up.begin(); //找几页更多\r\n		    big=n-t2;\r\n	 }\r\n	 eq=n-big-small;\r\n	 printf(\"%.6f %.6f %.6f\\n\",(float)(big)/n,(float)(eq)/n,(float)(small)/n);\r\n	}	\r\n	return 0; \r\n}\r\n\r\n', 'https://picsum.photos/id/100/800/450', '原创', 15, 1, 1, 1, 1, 1, '2021-05-11 13:51:07', '2021-05-11 13:51:07', 5, 1, '123', '1,2,3');
INSERT INTO `t_blog` VALUES (22, 'Gym100735DEG---KTU Programming Camp Day1', '\r\n#  KTU Programming Camp Day1\r\n\r\n@[toc]\r\n[题目链接：http://codeforces.com/gym/100735](http://codeforces.com/gym/100735)\r\n### D. Triangle Formation \r\n\r\n**题意**：n个棒组成多少三角形，每根棒只能用一次\r\n\r\n**题解**：n(<=15)，枚举两边和判断三角形\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\ntypedef long long ll;\r\nint n;\r\nll len[20];\r\nint used[20],ans=0;\r\nint main() {\r\n	scanf(\"%d\",&n);\r\n	for(int i=1; i<=n; i++) {\r\n		scanf(\"%lld\",&len[i]);\r\n	}\r\n	if(n<=2) return cout<<0,0;\r\n	memset(used,0,sizeof(used));\r\n	sort(len+1,len+n+1);\r\n	for(int i=1; i<=n; i++) {\r\n		for(int j=i+1; j<=n; j++) {\r\n			for(int k=j+1; k<=n; k++) {\r\n				if(!used[i]&&!used[j]&&!used[k]&&(len[i]+len[j]>len[k])) {\r\n					used[i]=1;\r\n					used[j]=1;\r\n					used[k]=1;\r\n					ans++;\r\n				}\r\n			}\r\n		}\r\n	}\r\n	return cout<<ans,0;\r\n}\r\n```\r\n\r\n### E. Restore\r\n\r\n**题意**：n * n，行、列、主副对角线和相等，不给出主对角线，还原n * n\r\n\r\n**题解**：除主对角线外所有元素总和为每行（列，对角线）的和的(n-1)倍；依次还原主对角线\r\n\r\n```cpp\r\n#include<bits/stdc++.h>\r\nusing namespace std;\r\ntypedef long long ll;\r\nll n,a[105][105],sr[105],sum=0;\r\nint main(){\r\n	scanf(\"%lld\",&n);\r\n	for(int i=0;i<n;i++){\r\n		for(int j=0;j<n;j++){\r\n			scanf(\"%lld\",&a[i][j]);\r\n			sr[i]+=a[i][j];\r\n		}\r\n		sum+=sr[i];\r\n	}\r\n	for(int i=0;i<n;i++){\r\n		a[i][i]=sum/(n-1)-sr[i];\r\n	}\r\n	for(int i=0;i<n;i++){\r\n		for(int j=0;j<n;j++){\r\n			cout<<a[i][j]<<\" \";\r\n		}\r\n		if(i!=n-1) cout<<endl;\r\n	}\r\n}\r\n```\r\n\r\n### G. LCS Revised\r\n\r\n **题意**：给定长为N的01组成的串A，B是任意一个长为N的01组成的串（2^n种），求AB的最长公共子序列的长度的最小值\r\n\r\n**题解**：统计A中0,1的个数，较小的即为答案\r\n\r\n```cpp\r\n#include<bits/stdc++.h> \r\nusing namespace std;\r\nstring s;\r\nint cnt0=0,cnt1=0;\r\nint main(){\r\n	cin>>s;\r\n    for(int i=0;i<s.size();i++){\r\n    	if(s[i]==\'0\') cnt0++;\r\n    	else cnt1++; \r\n	}\r\n	return cout<<min(cnt0,cnt1),0;	\r\n}\r\n```\r\n\r\n\r\n\r\n ', 'https://picsum.photos/id/100/800/450', '原创', 41, 1, 1, 1, 1, 1, '2021-05-12 08:13:51', '2021-05-12 08:13:51', 5, 1, 'Gym100735DEG---KTU Programming Camp Day1', '1,2,3');

-- ----------------------------
-- Table structure for t_blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_blog_tags`;
CREATE TABLE `t_blog_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) NULL DEFAULT NULL,
  `blog_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 126 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_blog_tags
-- ----------------------------
INSERT INTO `t_blog_tags` VALUES (63, 1, '11');
INSERT INTO `t_blog_tags` VALUES (64, 3, '11');
INSERT INTO `t_blog_tags` VALUES (65, 4, '11');
INSERT INTO `t_blog_tags` VALUES (66, 2, '11');
INSERT INTO `t_blog_tags` VALUES (74, 7, '12');
INSERT INTO `t_blog_tags` VALUES (75, 1, '12');
INSERT INTO `t_blog_tags` VALUES (76, 2, '13');
INSERT INTO `t_blog_tags` VALUES (77, 1, '13');
INSERT INTO `t_blog_tags` VALUES (78, 3, '13');
INSERT INTO `t_blog_tags` VALUES (79, 2, '14');
INSERT INTO `t_blog_tags` VALUES (80, 1, '14');
INSERT INTO `t_blog_tags` VALUES (81, 4, '14');
INSERT INTO `t_blog_tags` VALUES (82, 3, '14');
INSERT INTO `t_blog_tags` VALUES (84, 1, '16');
INSERT INTO `t_blog_tags` VALUES (85, 2, '16');
INSERT INTO `t_blog_tags` VALUES (86, 3, '16');
INSERT INTO `t_blog_tags` VALUES (87, 4, '16');
INSERT INTO `t_blog_tags` VALUES (88, 4, '15');
INSERT INTO `t_blog_tags` VALUES (89, 1, '17');
INSERT INTO `t_blog_tags` VALUES (90, 3, '17');
INSERT INTO `t_blog_tags` VALUES (91, 4, '17');
INSERT INTO `t_blog_tags` VALUES (92, 5, '17');
INSERT INTO `t_blog_tags` VALUES (93, 6, '17');
INSERT INTO `t_blog_tags` VALUES (94, 1, '18');
INSERT INTO `t_blog_tags` VALUES (95, 2, '18');
INSERT INTO `t_blog_tags` VALUES (96, 3, '18');
INSERT INTO `t_blog_tags` VALUES (100, 2, '20');
INSERT INTO `t_blog_tags` VALUES (101, 3, '20');
INSERT INTO `t_blog_tags` VALUES (102, 4, '20');
INSERT INTO `t_blog_tags` VALUES (110, 1, '10');
INSERT INTO `t_blog_tags` VALUES (111, 3, '10');
INSERT INTO `t_blog_tags` VALUES (112, 2, '10');
INSERT INTO `t_blog_tags` VALUES (113, 5, '10');
INSERT INTO `t_blog_tags` VALUES (114, 4, '10');
INSERT INTO `t_blog_tags` VALUES (115, 7, '10');
INSERT INTO `t_blog_tags` VALUES (116, 6, '10');
INSERT INTO `t_blog_tags` VALUES (117, 1, '21');
INSERT INTO `t_blog_tags` VALUES (118, 2, '21');
INSERT INTO `t_blog_tags` VALUES (119, 3, '21');
INSERT INTO `t_blog_tags` VALUES (120, 1, '22');
INSERT INTO `t_blog_tags` VALUES (121, 2, '22');
INSERT INTO `t_blog_tags` VALUES (122, 3, '22');
INSERT INTO `t_blog_tags` VALUES (123, 2, '19');
INSERT INTO `t_blog_tags` VALUES (124, 3, '19');
INSERT INTO `t_blog_tags` VALUES (125, 4, '19');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `blog_id` bigint(20) NULL DEFAULT NULL COMMENT '所属博客id',
  `parent_comment_id` bigint(20) NULL DEFAULT NULL COMMENT '父评论id',
  `admin_comment` tinyint(1) NULL DEFAULT NULL COMMENT '管理员评论',
  `parent_comment_nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父评论昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 'DobeQAQ', '569372795@qq.com', '测试评论功能', '/images/visitor.jpeg', '2021-05-12 18:34:48', 22, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (2, 'DobeQAQ', '569372795@qq.com', '测试', '/images/visitor.jpeg', '2021-05-12 18:34:51', 22, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (3, 'DobeQAQ', '569372795@qq.com', '123', '/images/visitor.jpeg', '2021-05-12 18:34:56', 22, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (4, 'DobeQAQ', '569372795@qq.com', '123', '/images/visitor.jpeg', '2021-05-12 18:34:59', 22, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (5, 'DobeQAQ', '569372795@qq.com', '这个是一个回复', '/images/visitor.jpeg', '2021-05-12 18:35:01', 22, 4, 0, 'DobeQAQ');
INSERT INTO `t_comment` VALUES (6, 'DobeQAQ', '569372795@qq.com', '二次回复', '/images/visitor.jpeg', '2021-05-12 18:35:03', 22, 5, 0, 'DobeQAQ');
INSERT INTO `t_comment` VALUES (7, 'DobeQAQ2', '569372795@qq.com', '新的评论', '/images/visitor.jpeg', '2021-05-12 18:35:07', 22, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (8, 'FrankieLiu', '569372795@qq.com', '三次回复', '/images/myPhoto.jpeg', '2021-05-12 18:35:10', 22, 6, 1, 'DobeQAQ');
INSERT INTO `t_comment` VALUES (9, 'FrankieLiu', '569372795@qq.com', '新的回复', '/images/myPhoto.jpeg', '2021-05-12 18:35:13', 22, -1, 1, NULL);
INSERT INTO `t_comment` VALUES (20, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '测试1', '/images/visitor.jpeg', '2021-05-12 19:14:51', 21, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (21, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '测试2', '/images/visitor.jpeg', '2021-05-12 19:15:02', 21, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (23, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '测试3', '/images/visitor.jpeg', '2021-05-12 19:17:25', 21, -1, 0, NULL);
INSERT INTO `t_comment` VALUES (24, 'DobeQAQ1', '1812480417@st.usst.edu.cn', '回复测试2', '/images/visitor.jpeg', '2021-05-12 19:17:34', 21, 21, 0, 'DobeQAQ0');
INSERT INTO `t_comment` VALUES (28, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '回复回复测试2', '/images/visitor.jpeg', '2021-05-12 19:26:36', 21, 24, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (29, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '回复回复测试2', '/images/visitor.jpeg', '2021-05-12 19:28:23', 21, 24, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (30, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '回复回复测试1', '/images/visitor.jpeg', '2021-05-12 19:30:05', 21, 24, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (31, 'DobeQAQ1', '1812480417@st.usst.edu.cn', '回复测试3', '/images/visitor.jpeg', '2021-05-12 19:31:51', 21, 23, 0, 'DobeQAQ0');
INSERT INTO `t_comment` VALUES (32, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '回复回复测试3', '/images/visitor.jpeg', '2021-05-12 19:33:07', 21, 31, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (33, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '回复回复测试3', '/images/visitor.jpeg', '2021-05-12 19:35:51', 21, 31, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (56, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '1', '/images/visitor.jpeg', '2021-05-12 22:42:50', 10, -1, 0, '');
INSERT INTO `t_comment` VALUES (57, 'DobeQAQ1', '1812480417@st.usst.edu.cn', '2', '/images/visitor.jpeg', '2021-05-12 22:43:01', 10, 56, 0, 'DobeQAQ0');
INSERT INTO `t_comment` VALUES (59, 'DobeQAQ0', '1812480417@st.usst.edu.cn', '3', '/images/visitor.jpeg', '2021-05-12 22:44:15', 10, 57, 0, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (60, 'DobeQAQ1', '1812480417@st.usst.edu.cn', '4', '/images/visitor.jpeg', '2021-05-12 22:44:21', 10, 59, 0, 'DobeQAQ0');
INSERT INTO `t_comment` VALUES (61, 'FrankieLiu', '569372795@qq.com', '博主发布', '/images/myPhoto.jpeg', '2021-05-12 22:45:25', 10, 60, 1, 'DobeQAQ1');
INSERT INTO `t_comment` VALUES (62, 'DobeQAQ', '1812480417@st.usst.edu.cn', '回复博主', '/images/visitor.jpeg', '2021-05-12 22:45:42', 10, 61, 0, 'FrankieLiu');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (1, 'java');
INSERT INTO `t_tag` VALUES (2, 'bfs');
INSERT INTO `t_tag` VALUES (3, 'dfs');
INSERT INTO `t_tag` VALUES (4, '线段树');
INSERT INTO `t_tag` VALUES (5, '贪心');
INSERT INTO `t_tag` VALUES (6, 'DP动态规划');
INSERT INTO `t_tag` VALUES (7, '数论');
INSERT INTO `t_tag` VALUES (16, '111');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1385951157603569669 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, '错误日志');
INSERT INTO `t_type` VALUES (2, '认知升级');
INSERT INTO `t_type` VALUES (3, 'JavaScript');
INSERT INTO `t_type` VALUES (5, 'C++');
INSERT INTO `t_type` VALUES (6, 'CSS');
INSERT INTO `t_type` VALUES (7, 'HTML');
INSERT INTO `t_type` VALUES (8, 'Algorithm Notes');
INSERT INTO `t_type` VALUES (9, 'java');
INSERT INTO `t_type` VALUES (10, 'LeetCode');
INSERT INTO `t_type` VALUES (11, 'WEB1');
INSERT INTO `t_type` VALUES (12, '1');
INSERT INTO `t_type` VALUES (13, '2');
INSERT INTO `t_type` VALUES (14, '3');
INSERT INTO `t_type` VALUES (15, '4');
INSERT INTO `t_type` VALUES (16, '5');
INSERT INTO `t_type` VALUES (17, '6');
INSERT INTO `t_type` VALUES (18, '7');
INSERT INTO `t_type` VALUES (19, '8');
INSERT INTO `t_type` VALUES (20, '9');
INSERT INTO `t_type` VALUES (21, '10');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `type` int(11) NULL DEFAULT NULL COMMENT '权限',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'FrankieLiu', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '569372795@qq.com', '/images/myPhoto.jpeg', 1, '2021-05-11 08:28:02', '2021-05-11 08:28:05');

SET FOREIGN_KEY_CHECKS = 1;
