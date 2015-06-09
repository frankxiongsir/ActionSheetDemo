//
//  ViewController.m
//  ActionSheetDemo
//
//  Created by Xiongchengfu on 15/6/4.
//  Copyright (c) 2015年 Xiongchengfu. All rights reserved.
//

#import "ViewController.h"
#import "TRActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTitle:(id)sender
{
    TRActionSheet *sheet = [[TRActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"一个创业者一定要有一批朋友，这批朋友是你这么多年来诚信积累起来的，越积越大，越积越大。像我帐号的财富，如果碰上很多资金上的问题，这就是每天积累下来的诚信",@"一个好的东西往往是说不清楚的，说得清楚的往往不是好东西",@"要有个性，个性不是喊口号，不是成功学，而是别人失败的经验！",@"男人的胸怀是委屈撑大的",@"书读的不多没有关系，就怕不在社会上读书",@"在我看来有三种人，生意人：创造钱;商人：有所为，有所不为。企业家：为社会承担责任。企业家应该为社会创造环境。企业家必须要有创新的精神",@"我永远相信只要永不放弃，我们还是有机会的。最后，我们还是坚信一点，这世界上只要有梦想，只要不断努力，只要不断学习，不管你长得如何，不管是这样，还是那样，男人的长相往往和他的的才华成反比。今天很残酷，明天更残酷，后天很美好，但绝对大部分是死在明天晚上，所以每个人不要放弃今天", nil];
    [sheet setTitleColor:[UIColor grayColor] fontSize:15];
    [sheet setCancelButtonTitleColor:[UIColor redColor] bgColor:[UIColor grayColor] fontSize:15];
    [sheet show];
}
@end
