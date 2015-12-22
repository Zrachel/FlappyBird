//
//  GameViewController.m
//  flappy
//
//  Created by Rachel on 15/12/19.
//  Copyright © 2015年 Rachel. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(IBAction)Startaction:(id)sender{
    btn_startgame.hidden = YES;
    timer_bird_move = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    [self PlaceTunnels];
    timer_tunnel_move = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(TunnelMoving) userInfo:nil repeats:YES];
    imview_bottom.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - imview_bottom.bounds.size.height/2);
    imview_tunnel_bottom.hidden = NO;
    imview_tunnel_top.hidden = NO;
    label_gameover.hidden = YES;
}

-(void)Gameover{
    [timer_bird_move invalidate];
    [timer_tunnel_move invalidate];
    
    imview_bird.hidden = YES;
    imview_tunnel_bottom.hidden = YES;
    imview_tunnel_top.hidden = YES;
    
    label_gameover.hidden = NO;
    btn_return.hidden = NO;
    NSLog(@"Gameover");
}

-(void)IncScore{
    score += 1;
    //label_score.text = [NSString stringWithFormat:@"%i", score];
}

-(void) TunnelMoving{
    imview_tunnel_top.center = CGPointMake(imview_tunnel_top.center.x - 1, imview_tunnel_top.center.y);
    imview_tunnel_bottom.center = CGPointMake(imview_tunnel_bottom.center.x - 1, imview_tunnel_bottom.center.y);
    
    if (imview_tunnel_bottom.center.x < 0) {
        [self PlaceTunnels];
    }
    
    if (CGRectIntersectsRect(imview_bird.frame, imview_tunnel_bottom.frame)) {
        [self Gameover];
    }
    if (CGRectIntersectsRect(imview_bird.frame, imview_tunnel_top.frame)) {
        [self Gameover];
    }
    /*
    if (CGRectIntersectsRect(imview_bird.frame, imview_top.frame)) {
        [self Gameover];
    }
    if (CGRectIntersectsRect(imview_bird.frame, imview_bottom.frame)){
        [self Gameover];
    } */
   
    
    if (imview_tunnel_bottom.center.x == imview_tunnel_bottom.bounds.size.width / 2) {
        [self IncScore];
        //imview_tunnel_bottom.center = CGPointMake(imview_tunnel_bottom.center.x, imview_tunnel_bottom.center.y);
        NSLog(@"Current imview_tunnel_bottom.center AFTER: [%f %f]", imview_tunnel_top.center.x, imview_tunnel_top.center.y);
    }
}

-(void)BirdMoving{
    bird_speed -= 1;
    //NSLog(@"before:x:%f\ty:%f\ts:%d", imview_bird.center.x, imview_bird.center.y,bird_speed);
    //NSLog(@"Bird height: %i", bird_height);
    if (bird_speed < -15) {
        bird_speed = -15;
    }
    int cur_birdheight = imview_bird.center.y - bird_speed;
/*    if (bird_speed < 0) {
        imview_bird.image = [UIImage imageNamed:@("bird-down.png")];
    } else {
        imview_bird.image = [UIImage imageNamed:@("bird-up.png")];
    }
 */
    CGSize viewsize = self.view.bounds.size;
    
    if (cur_birdheight > viewsize.height) {
        cur_birdheight = viewsize.height;
    }
    if (cur_birdheight < 0) {
        cur_birdheight = 0;
    }
    if (old_height - cur_birdheight > 15) {
        cur_birdheight = old_height - 15;
    } else if (cur_birdheight - old_height > 15) {
        cur_birdheight = old_height + 15;
    }
    imview_bird.center = CGPointMake(imview_bird.center.x, cur_birdheight);
    old_height = cur_birdheight;
}

-(void)PlaceTunnels{
    CGSize viewsize = self.view.bounds.size;
    int maxx = imview_tunnel_top.bounds.size.height / 2;
    int minn = - imview_tunnel_top.bounds.size.height / 2 + imview_top.bounds.size.height;
    int range_tunnel_y = maxx - minn;
    random_toptunnel_pos = arc4random()%range_tunnel_y;
    random_toptunnel_pos += minn;
    imview_tunnel_top.center = CGPointMake(viewsize.width, random_toptunnel_pos);
    imview_tunnel_bottom.center = CGPointMake(viewsize.width, random_toptunnel_pos + 150 + imview_tunnel_top.bounds.size.height);
    //NSLog(@"Current imview_tunnel_bottom.center: [%f %f]", imview_tunnel_bottom.center.x, imview_tunnel_bottom.center.y);
    //NSLog(@"Current imview_tunnel_top.center: [%f %f]", imview_tunnel_top.center.x, imview_tunnel_top.center.y);
    
    while (imview_tunnel_bottom.center.y >= self.view.bounds.size.height + maxx - imview_bottom.bounds.size.height) {
        imview_tunnel_bottom.center = CGPointMake(imview_tunnel_bottom.center.x, imview_tunnel_bottom.center.y - 20);
        imview_tunnel_top.center = CGPointMake(imview_tunnel_top.center.x, imview_tunnel_top.center.y - 20);
    }
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    bird_speed = 10;
}

- (void)viewDidLoad {
    imview_bottom.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - imview_bottom.bounds.size.height/2);
    imview_tunnel_bottom.hidden = YES;
    imview_tunnel_top.hidden = YES;
    label_gameover.hidden = YES;
    btn_return.hidden = YES;
    label_score.hidden = YES;
    imview_bird.center = CGPointMake(imview_bird.center.x, self.view.bounds.size.height/2);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
